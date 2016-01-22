#' Widget output function for use in Shiny
#'
#' @param outputId outputId
#' @param width width
#' @param height height
#' @export
jsonviewOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'jsonview', width, height,
                                 package = 'jsonview')
}

#' Widget render function for use in Shiny
#'
#' @param expr expr
#' @param env env
#' @param quoted quoted
#' @export
renderJsonview <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, xmlviewOutput, env, quoted = TRUE)
}
