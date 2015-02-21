shinyUI(fluidPage(
    titlePanel("Buy or Rent?"),
    
    sidebarLayout(
        
        sidebarPanel(
            numericInput("rent",
                         label = h5("Monthly Rent To Compare"),
                         value = 2700),
            selectInput("type",
                        label = h5("Home Type"),
                        choices = list("Single Family Home",
                                       "Townhouse / Condo"),
                        selected = "Single Family Home"),
            conditionalPanel(condition = "input.type == 'Townhouse / Condo'",
                             numericInput("hoa",
                                          label = h5("HOA Dues"),
                                          value = 300)),
            numericInput("price",
                         label = h5("Home Price"),
                         value = 665000,
                         step = 500),
            sliderInput("down",
                        label = h5("Down Payment (%)"),
                        min = 0, max = 100, value = 20),
            sliderInput("rate",
                         label = h5("Interest Rate (%)"),
                         min = 0, max = 10.0, value = 3.95,
                         step = 0.05),
            radioButtons("term",
                         label = h5("Loan Term"),
                         choices = list("30-Year Fixed",
                                        "15-Year Fixed"),
                         selected = "30-Year Fixed"),
            selectInput("tax",
                        label = h5("US Tax Bracket"),
                        choices = list("10%", "15%", "25%",
                                       "28%", "33%", "35%", "39.6%"),
                        selected = "25%"),
            sliderInput("prop",
                        label = h5("Property Tax Rate (%)"),
                        min = 0, max = 4.0, value = 1.25,
                        step = 0.01)
        ),
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("Welcome!",
                                 h2("Buying versus Renting"),
                                 br(),
                                 p("Determining whether to purchase or rent a home 
                                   can be a very difficult decision.  This simple app 
                                   has been designed to help give you some information
                                   in order to make this decision easier from a financial
                                   point of view.  ", strong("However,"), " it is not intended to cover every
                                   possible data point relevant to making such a big 
                                   decision.  Please review the instructions and comments
                                   below and best of luck in finding your new future home!"),
                                 br(),
                                 h4("Instructions"),
                                 p("To the left, you will notice a variety of options to select.  
                                   The more accurate you can be with estimating these parameters, 
                                   the better this tool will be able to guide you in your decision.  
                                   When in doubt, a quick search online can usually get you a
                                   reasonable estimate for your local area.  The list of choices 
                                   are as follows:"),
                                 tags$ul(
                                   tags$li(div(strong("Monthly Rent to Compare "), "- Enter the
                                               expected monthly rent for your area that will 
                                               be compared against purchasing a home.")),
                                   tags$li(div(strong("Home Type "), "- Choose between a single
                                               family home or a townhouse/condo.  Choosing the
                                               townhouse/condo option will bring up a new box 
                                               to enter the next parameter, HOA Dues.")),
                                   tags$li(div(strong("HOA Dues "), "- Enter the expected 
                                               Homeowner's Association Dues.  This option will 
                                               only be displayed if townhouse/condo is selected
                                               from the Home Type parameter.")),
                                   tags$li(div(strong("Home Price "), "- Enter the expected 
                                               purchase price of the home.  This should be the 
                                               full home value, not the loan value.")),
                                   tags$li(div(strong("Down Payment (%) "), "- Use the slider 
                                               to select the percent of home value expected 
                                               to be paid as a down payment.",
                                               strong("NOTE: "), "Values below 20% will result in the
                                                      addition of Private Mortgage Insurance (PMI) to 
                                                      the monthly payment.  See below for more 
                                                      information.")),
                                   tags$li(div(strong("Interest Rate (%)"), "- Use the slider 
                                               to select the expected interest rate for a 
                                               home loan.  Average rates are widely available 
                                               online if you need a quick estimate.")),
                                   tags$li(div(strong("Loan Term "), "- Choose between a 30-Year 
                                               and a 15-Year Fixed Rate loan.  While there are 
                                               many other options available for loans, the two 
                                               listed here are the most popular.")),
                                   tags$li(div(strong("US Tax Bracket "), "- Select your 
                                               estimated tax bracket from the options available.  
                                               This will be used to estimate the benefit received 
                                               from the mortgage interest deduction that is available 
                                               to homeowning taxpayers in the United States.")),
                                   tags$li(div(strong("Property Tax Rate (%) "), "- Use the slider 
                                               to select the estimated property tax rate for your 
                                               local area."))
                                 ),
                                 br(),
                                 p("Once you have selected your inputs, click the Results tab above.  
                                     This will take you to the results screen, where you can continue 
                                     to adjust the options to the left to see the impact of your choices."),
                                 br(),
                                 h4("A couple of quick thoughts..."),
                                 p("This tool, while incorporating many useful inputs, will 
                                   invariably be only an estimate for any particular individual.  Certain 
                                   items can be calculated with certainty, but the benefit due to mortgage 
                                   interest deduction and the property taxes are only rough estimates.  This 
                                   is because of the varying tax laws and application of those tax laws 
                                   as it applys to different individuals in different locations under 
                                   different financial situations."),
                                 p("Private Mortgage Insurance is a common requirement for home buyers 
                                   that choose to put less than 20% of the home value as a down payment.  
                                   This insurance protects the lender (the Bank) and is paid for by the 
                                   customer (you).  For simplicity, this is assumed to be 0.55% of the 
                                   loan amount."),
                                 p("The monthly cost to buy a home is calculated as the sum 
                                   of all the varied elements already described for the first month of
                                   ownership.  The split between interest and principal in each payment 
                                   as well as the associated benefit from deducting mortgage interest on 
                                   your taxes, will vary over time.  For simplicity, only the cost of the 
                                   first month is used in this tool."),
                                 p("Finally, this tool does not consider changes in home value.  It 
                                   is not meant for those who wish to speculate on the value of a home.")
                        ),
                        tabPanel("Results", h1(textOutput("text1")),
                                 br(),
                                 p(textOutput("text2")),
                                 p(textOutput("text3")))
            )
        )
    )
))