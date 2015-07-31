library(dygraphs)
library(datasets)
library(DT)
library(powstreams)

noneselected = "-- no variable selected --"
metab_models = dplyr::add_rownames(mda.streams::parse_metab_model_name(mda.streams::list_metab_models()),'model_name') %>% as.data.frame()

models <<- list()

shinyServer(function(input, output) {
  
  get_model_data <- function(){
    for (row in input$x1_rows_selected){
      r.chr <- as.character(row)
      if (is.null(names(models)) || !names(models) %in% r.chr){
        file = download_metab_model(metab_models[row, ]$model_name, on_local_exists = 'skip')
        if (file.size(file) > 0){
          load(file) # site-specific, run-specific model object
          models[[r.chr]] <- mm
        } else {
          models[[r.chr]] <- list() # empty model
        }
      } # // else: skip it, because it is already in the list
    }
    rmv.nm <- names(models)[!names(models) %in% as.character(input$x1_rows_selected)]
    # remove all models that aren't selected ____ NOT IMPLEMENTED!!____CHECK THIS!
    models[[rmv.nm]] <- NULL
    models <<- models
    return()
  }
  
  react_model_data <- reactive({
    if (length(input$x1_rows_selected)>0){
      return(get_model_data())
    } else {
      return()
    }
  })
  
  merge_extract <- function(){
    empty.xts <- xts::xts(c(NA,NA), order.by=as.POSIXct(c('2012-01-01','2012-01-02')))
    names(empty.xts) <- 'NA'
    return(empty.xts)
  }
  
  output$x1 = DT::renderDataTable(metab_models[,c(-1,-2)], server = FALSE, rownames=FALSE, #filter='top',
                                  options=list(pageLength=15,
                                               order=list(list(2,'desc'))))

  colors = RColorBrewer::brewer.pal(5, "Dark2")
  output$dygraph1 <- renderDygraph({
    react_model_data()
    data = merge_extract()
    dygraph(data, group = "powstreams") %>%
      dygraphs::dyOptions(colors = colors[seq_len(ncol(data))], drawPoints=TRUE, pointSize=2) %>%
      dygraphs::dyHighlight(highlightSeriesBackgroundAlpha = 0.65, hideOnMouseOut = TRUE) %>%
      dygraphs::dyAxis('y', label="Metabolism (units...)")
  })
  output$dygraph2 <- renderDygraph({
    data = merge_extract()
    dygraph(data, group = "powstreams") %>%
      dygraphs::dyOptions(colors = colors[seq_len(ncol(data))], drawPoints=TRUE, pointSize=2) %>%
      dygraphs::dyHighlight(highlightSeriesBackgroundAlpha = 0.65, hideOnMouseOut = TRUE) %>%
      dygraphs::dyAxis('y', label="Metabolism (units...)")
  })
  output$dygraph3 <- renderDygraph({
    data = merge_extract()
    dygraph(data, group = "powstreams") %>%
      dygraphs::dyOptions(colors = colors[seq_len(ncol(data))], drawPoints=TRUE, pointSize=2) %>%
      dygraphs::dyHighlight(highlightSeriesBackgroundAlpha = 0.65, hideOnMouseOut = TRUE) %>%
      dygraphs::dyAxis('y', label="K600 (units...)") 
  })
  
#   plots <- reactive({
#     data = get_model_data()
#     #u_i <- model@fit[c('minimum')] < input$min | is.na(model@fit[c('minimum')]) # keep the NAs to break up the plot
#     par(mfcol=c(1,3))
#     plot(as.numeric(data$K600[,1]), as.numeric(data$ER[,1]), col=colors[1], asp=1)
#     if (ncol(data$K600)>1){
#       for (i in seq_len(ncol(data$K600))[-1]){
#         points(as.numeric(data$K600[,i]), as.numeric(data$ER[,i]), col=colors[i])
#       }
#     }
#     plot(as.numeric(data$GPP[,1]), as.numeric(data$ER[,1]), col=colors[1], asp=1)
#     if (ncol(data$GPP)>1){
#       for (i in seq_len(ncol(data$GPP))[-1]){
#         points(as.numeric(data$GPP[,i]), as.numeric(data$ER[,i]), col=colors[i])
#       }
#     }
#     plot(as.numeric(data$K600[,1]), as.numeric(data$ER[,1]), col=colors[1], asp=1)
#     if (ncol(data$K600)>1){
#       for (i in seq_len(ncol(data$K600))[-1]){
#         points(as.numeric(data$K600[,i]), as.numeric(data$ER[,i]), col=colors[i])
#       }
#     }
#   })
#   
#   output$plot <- renderPlot({
#     plots()
#   })
  
})