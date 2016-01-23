#' Widget output function for use in Shiny
#'
#' @param outputId outputId
#' @param width width
#' @param height height
#' @export
jsontreeviewOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'jsontreeview', width, height,
                                 package = 'jsontreeview')
}

#' Widget render function for use in Shiny
#'
#' @param expr expr
#' @param env env
#' @param quoted quoted
#' @export
renderJsontreeview <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, jsontreeviewOutput, env, quoted = TRUE)
}
