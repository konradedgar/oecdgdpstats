library(shiny); library(XML2R); library(ggplot2)

# Server logic to draw line chart for the GDP
shinyServer(function(input, output) {
  
# URL to XML data as derived from the OECD website
oecd.gdp.url <- "http://stats.oecd.org/restsdmx/sdmx.ashx/GetData/GOV_DEBT/AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+OTO.AMT.A.PCT.P1/all?startTime=2000&endTime=2010"
  
# Manufacturing the data set, the code follows the 'Reading OECD.Stat into R' post available on R-Bloggers
gdp.dta <- XML2Obs(oecd.gdp.url)
gdp.dta.table <- collapse_obs(gdp.dta)
keys <- gdp.dta.table[["MessageGroup//DataSet//Series//SeriesKey//Value"]]
dates <- gdp.dta.table[["MessageGroup//DataSet//Series//Obs//Time"]]
values <- gdp.dta.table[["MessageGroup//DataSet//Series//Obs//ObsValue"]]
country_list <- keys[keys[,1]== "COU" | keys[,1]== "COUNTRY"]
country_list <- country_list[
  (length(country_list)*1/3+1):(length(country_list)*2/3)]
dat <- cbind.data.frame(as.numeric(dates[,1]),as.numeric(values[,1]))
colnames(dat) <- c('date', 'value')
dat$country <- c(country_list[1], country_list[cumsum(diff(dat$date) <= 0) + 1])
dat$value2 <- signif(dat$value,2)

# Make nice country numbers
cntr.indx <- as.data.frame(unique(dat$country))
cntr.indx$index <- 1:nrow(cntr.indx) 
dat <- merge(x = dat, y = cntr.indx, by.x = "country", 
             by.y = "unique(dat$country)")

  output$linePlot <- renderPlot({
    # Prepare the data set
    dat.chrt <- subset(dat, index == as.numeric(input$countryGroup))
    
    # Graph the chart
    ggplot(dat.chrt) + 
      geom_line(aes(date,value,colour=country), size=1.5) +
      geom_point(aes(date,value,colour=country),size=5, fill="white") +
      scale_x_continuous(breaks=seq(round(max(dat$date),0))) +
      theme(axis.title.x= element_text(face = "bold", size=16),
            axis.title.y= element_text(face = "bold", size=16),
            axis.text.x = element_text(size=14, color = "black"),
            axis.text.y = element_text(size=14, color = "black"),
            panel.background = element_rect(fill = 'white'),
            legend.text=element_text(size=12),
            panel.border = element_rect(fill=NA,color="black", size=0.5, 
                                    linetype="solid")) +
    xlab("Year") + 
    ylab("Debt % of GDP")
  })
})
