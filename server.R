shinyServer(function(input, output) {
    
    buycash <- reactive({
          int <- input$rate / (12 * 100)
          months <- switch(input$term,
                          "30-Year Fixed" = 360,
                          "15-Year Fixed" = 180)
          prin <- ifelse(is.na(input$price), 0, input$price) * (1 - input$down/100)
          pmt <- prin * int / (1 - (1 + int) ^ (-months))
          ipmt <- prin * int
          ppmt <- pmt - ipmt
          tax <- switch(input$tax,
                        "10%" = 0.10,
                        "15%" = 0.15,
                        "25%" = 0.25,
                        "28%" = 0.28,
                        "33%" = 0.33,
                        "35%" = 0.35,
                        "39.6%" = 0.396)
          deduct <- ipmt * tax
          hoa <- ifelse(input$type == "Single Family Home", 0, ifelse(is.na(input$hoa), 0, input$hoa))
          ptax <- ifelse(is.na(input$price), 0, input$price) * (input$prop/100 / 12)
          pmi <- (ifelse(input$down < 20, 0.0055, 0) / 12) * prin
          cash <- pmt + ptax + hoa + pmi
          cash
    })
    
    buyvalue <- reactive({
          int <- input$rate / (12 * 100)
          months <- switch(input$term,
                          "30-Year Fixed" = 360,
                          "15-Year Fixed" = 180)
          prin <- ifelse(is.na(input$price), 0, input$price) * (1 - input$down/100)
          pmt <- prin * int / (1 - (1 + int) ^ (-months))
          ipmt <- prin * int
          ppmt <- pmt - ipmt
          tax <- switch(input$tax,
                        "10%" = 0.10,
                        "15%" = 0.15,
                        "25%" = 0.25,
                        "28%" = 0.28,
                        "33%" = 0.33,
                        "35%" = 0.35,
                        "39.6%" = 0.396)
          deduct <- ipmt * tax
          hoa <- ifelse(input$type == "Single Family Home", 0, ifelse(is.na(input$hoa), 0, input$hoa))
          ptax <- ifelse(is.na(input$price), 0, input$price) * (input$prop/100 / 12)
          pmi <- (ifelse(input$down < 20, 0.0055, 0) / 12) * prin
          cash <- pmt + ptax + hoa + pmi
          value <- cash - deduct - ppmt
          value
    })
    
    output$text1 <- renderText({
        ifelse(ifelse(is.na(input$rent), 0, input$rent) < buyvalue(), "Keep Renting!",
               ifelse(ifelse(is.na(input$rent), 0, input$rent) < buycash(), "Tough Call!", "Buy Now!"))
    })
    
    output$text2 <- renderText({
        paste("Your all-in cash mortgage payment is ", round(buycash(), 0),
              " compared to your rent payment of ", round(input$rent, 0), ".")
    })
    
    output$text3 <- renderText({
        ifelse(ifelse(is.na(input$rent), 0, input$rent) < buyvalue(), paste("On both a cash and a value basis, it 
                    cheaper to rent as opposed to buy.  It is cheaper from a financial 
                    perspective, but keep in mind there are many valid non-financial 
                    reasons to purchase a home."),
             ifelse(ifelse(is.na(input$rent), 0, input$rent) < buycash(), paste("However, on a total value basis, 
                    your monthly cost to own is actually", round(buyvalue(),0), ".  This
                    is because you receive tax savings from the interest you pay as well 
                    as because a portion of your payment goes towards owning an asset (your home)."),
                    paste("On both a cash and a value basis, it is cheaper to buy as opposed 
                          to rent.")))
    })
})