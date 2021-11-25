header <- dashboardHeader(title = "Gender Gap Analysis")

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(text = "Gap Earnings", 
             tabName = "gap", 
             icon = icon("dashboard"),
             badgeLabel = "annually",
             badgeColor = "red"),
    menuItem(text = "Correlation Plot", 
             tabName = "corr", 
             icon = icon("th")),
    menuItem(text = "Data", 
             tabName = "dat", 
             icon = icon("database")),
    selectInput(inputId = "year", 
                label = "Choose year:", 
                choices = unique(workers_clean$year))
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "gap",
            h2("Gap Gender Annually Report", align = "center"),
            fluidRow(valueBox(nrow(workers_clean), 
                              "Data", 
                              icon = icon("credit-card"), 
                              color = "red"),
                     valueBox(round(mean(workers_clean$total_earnings),2), 
                              "Mean Earnings", 
                              icon = icon("address-card"),
                              color = "red"),
                     valueBox(round(mean(workers_clean$total_workers), 2), 
                              "Mean Total Workers", 
                              icon = icon("adjust"),
                              color = "red")),
            plotlyOutput(outputId = "plot_col")),
    tabItem(tabName = "corr",
            radioButtons(inputId = "yvar", 
                         label = "Choose numerical variables", 
                         choices = colnames(select_if(workers_clean[,-1], is.numeric)) %>% 
                           str_replace_all(pattern = "_", " ") %>% 
                           str_to_title()
            ),
            plotlyOutput(outputId = "plot_corr")
    ),
    tabItem(tabName = "dat", 
            dataTableOutput(outputId = "data_workers"))
    
  )
)

dashboardPage(
  skin = "red",
  header = header,
  body = body,
  sidebar = sidebar
)