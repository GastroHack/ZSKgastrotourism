
# login details to AWS
Sys.setenv(
  "AWS_ACCESS_KEY_ID" = "",
  "AWS_SECRET_ACCESS_KEY" = "",
  "AWS_DEFAULT_REGION" = "eu-west-2")
get_bucket(bucket ='')

# read data from s3
data12 <- s3read_using(FUN = readRDS, object = "")
summary(data12)

server <- function(input, output,session) {

  revenue.total <- data12 %>% group_by(month) %>% summarise(revenue=sum(revenue)/1000000)

  revenue.total.winter <- data12 %>% filter(season=="winter") %>% group_by(month) %>% summarise(revenue=sum(revenue)/1000000)
  revenue.total.hotel <- data12 %>% filter(type=="hotel") %>% group_by(month) %>% summarise(revenue=sum(revenue)/1000000)
  revenue.total.cablecar <- data12 %>% filter(type=="cable car operator") %>% group_by(month) %>% summarise(revenue=sum(revenue)/1000000)

  revenue.total.summer <- data12 %>% filter(season=="winter") %>% group_by(month) %>% summarise(revenue=sum(revenue)/1000000)
  revenue.total.summer.bike <- data12 %>% filter(type=="bike rental") %>% group_by(month) %>% summarise(revenue=sum(revenue)/1000000)
  revenue.total.pool <- data12 %>% filter(type=="outdoor pool") %>% group_by(month) %>% summarise(revenue=sum(revenue)/1000000)

  #total revenue trend
  output$plot1 <- renderPlotly(
    p.summary.revenue <-  plot_ly (
      x =revenue.total$month,
      y = revenue.total$revenue, type = 'scatter' , mode = 'lines' ) %>%
      layout(yaxis=list(title="Revenue (€ mm)"),xaxis=list(title="Month"), title = 'Total Revenue trend')

  )
  #winter total revenue
  output$plot4 <- renderPlotly(
    p.summary.revenue.winter <-  plot_ly (
      x =revenue.total.winter$month,
      y = revenue.total.winter$revenue, type = 'scatter' , mode = 'lines' ) %>%
    layout(yaxis=list(title="Winter Revenue (€ mm)"),xaxis=list(title="Month"), title = 'Winter Revenue trend')
  )
  #hotel revenue trend
  output$plot5 <- renderPlotly(
    p5 <-  plot_ly (
      x =revenue.total.hotel$month,
      y = revenue.total.hotel$revenue, type = 'scatter' , mode = 'lines' )%>%
      layout(yaxis=list(title="Revenue (€ mm)"),xaxis=list(title="Month"), title = 'Hotel Revenue trend')
  )

  #cable car revenue trend
  output$plot6 <- renderPlotly(
    p5 <-  plot_ly (
      x =revenue.total.cablecar$month,
      y = revenue.total.cablecar$revenue, type = 'scatter' , mode = 'lines' )%>%
      layout(yaxis=list(title="Revenue (€ mm)"),xaxis=list(title="Month"), title = 'Cable Car Revenue trend')
  )

  # summer revenue trend
  output$plot7 <- renderPlotly(
    p.summary.revenue.summer <-  plot_ly (
      x =revenue.total.summer$month,
      y = revenue.total.summer$revenue, type = 'scatter' , mode = 'lines' )%>%
      layout(yaxis=list(title="Revenue (€ mm)"),xaxis=list(title="Month"), title = 'Summer Revenue trend')
  )

  # bike rental revenue trend
  output$plot8 <- renderPlotly(
    p.summary.revenue.summer <-  plot_ly (
      x = revenue.total.summer.bike$month,
      y = revenue.total.summer.bike$revenue, type = 'scatter' , mode = 'lines' )%>%
      layout(yaxis=list(title="Revenue (€ mm)"),xaxis=list(title="Month"), title = 'Bike Rental Revenue trend')
  )

  #outdoor pool revenue trend
  output$plot9 <- renderPlotly(
    p.summary.revenue.summer <-  plot_ly (
      x = revenue.total.pool$month,
      y = revenue.total.pool$revenue, type = 'scatter' , mode = 'lines' )%>%
      layout(yaxis=list(title="Revenue (€ mm)"),xaxis=list(title="Month"), title = 'Outdoor Pool Revenue trend')
  )

}
