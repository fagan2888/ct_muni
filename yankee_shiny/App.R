
library(rsconnect)
library(data.table)
library(ggplot2)
library(plotly)
library(shiny)
library(glue)
library(openxlsx)
library(knitr)

#Load data
yankee <- as.data.table(openxlsx::read.xlsx("yankee.xlsx"))
yankee[,`:=`(`Fiscal Year`=Fiscal.Year,
             Fiscal.Year=NULL)]

#Plot function
map_score <- function(muni){
  
  frame <- yankee[`Fiscal Year` %in% as.character(c(2004:2017)),
                  .SD,.SDcols=patterns("Score|Muni|Year")][
                    ][,melt(.SD, measure.vars=patterns("Score"))][
                      ][!is.na(value)]
  
  town <- frame[Municipality == muni]
  
  p <- ggplot(data=frame) +
    geom_line(aes(`Fiscal Year`,value,group=Municipality))+
    geom_line(data=town,
              aes(`Fiscal Year`,value,col="red",group=Municipality),size=0.5)+
    scale_color_manual(values = "red")+
    theme_bw() +
    theme(legend.position = "none")+
    labs(main="Breakdown of Score for {muni}",
         caption = "Source: State of CT OPM Municipal Fiscal Indicators") +
    xlab("Fiscal Year")+
    ylab("Risk Score")+
    scale_x_discrete(breaks=c(2005,2010,2015))+
    facet_wrap(~variable,scale="free",ncol=2)
  
  plotly::ggplotly(p)
  
}


ui <- fluidPage(
  titlePanel("Risk Score History of Selected Town"),
  br(),
  br(),
  selectInput(
    "Municipality", label = "Select Municipality:",
    choices = unique(yankee$Municipality), selected = "Bridgeport"),
  mainPanel(
    
    # Output: Tabset w/ plot, summary, and table ----
    tabsetPanel(type = "tabs",
                tabPanel("Plot", plotly::plotlyOutput("spaghetti"), height="500px"),
                tabPanel("Table", tableOutput("table"))
    )
  )
)
server <- function(input, output) {
  
  output$spaghetti <- plotly::renderPlotly({
    
    map_score(input$Municipality)
    
  })
  
  output$table <- renderTable({
    yankee[Municipality == input$Municipality,.SD,.SDcols=patterns(c("Score|Year|Muni"))]
  })
  options = list(height = 1000)  
}

shinyApp(ui = ui, server = server)