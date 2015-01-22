library(shiny)

# Our simple interface definition comes here.
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Central Government Debt as % of GDP"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("countryGroup", 
                         label = h3("Country"), 
                         choices = list("AUS" = 1,
                                        "AUT" = 2,
                                        "BEL" = 3,
                                        "CAN" = 4,
                                        "CHE" = 5,
                                        "CHL" = 6,
                                        "CZE" = 7,
                                        "DEU" = 8,
                                        "DNK" = 9,
                                        "ESP" = 10,
                                        "EST" = 11,
                                        "FIN" = 12,
                                        "FRA" = 13,
                                        "GBR" = 14,
                                        "GRC" = 15,
                                        "HUN" = 16,
                                        "IRL" = 17,
                                        "ISL" = 18,
                                        "ISR" = 19,
                                        "ITA" = 20,
                                        "JPN" = 21,
                                        "KOR" = 22,
                                        "LUX" = 23,
                                        "MEX" = 24,
                                        "NLD" = 25,
                                        "NOR" = 26,
                                        "NZL" = 27,
                                        "POL" = 28,
                                        "PRT" = 29,
                                        "SVK" = 30,
                                        "SVN" = 31,
                                        "SWE" = 32,
                                        "TUR" = 33,
                                        "USA" = 34),
                         selected = 1),
      width = 2
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("linePlot", width = "100%", height = 600),
      width = 10
    )
  )
))
