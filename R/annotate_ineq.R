#' Annotate ggplot2 chart with inequality metric
#'
#' Adds text annotation to chart with any inequality measure from ineq::ineq
#' Inequality measures include Gini, RS, Atkinson, Theil, Kol, var, square.var, entropy
#'
#' @md
#' @param data_ineq Data to calculate the inequality metric on.
#' @param freq_ineq (optional) Frequency of each observation, defaults to 1, should be same length as data
#' @param measure_ineq Name of measure to use; defaults to Gini.
#' @param x annotation x-axis position, defaults to 0.1.
#' @param y annotation y-axis position, defaults to 0.95.
#' @param decimals number of decimals to show, defaults to 2.
#' @param sep_ineq text separator between annotation label and value.
#' @param ... any additional parameters to ggplot2::annotate().
#'
#' @references
#'   [Gini coefficient from Wikipedia](https://en.wikipedia.org/wiki/Gini_coefficient)
#' @importFrom ggplot2 annotate
#' @examples
#' library(gglorenz)
#'
#' ggplot(billionaires, aes(TNW)) +
#'     stat_lorenz() +
#'     annotate_ineq(billionaires$TNW)
#'
#' ggplot(billionaires, aes(TNW)) +
#'     stat_lorenz(desc = TRUE) +
#'     geom_abline(linetype = "dashed") +
#'     theme_bw() +
#'     annotate_ineq(billionaires$TNW, measure_ineq = "RS", color = "red",
#'                   family = theme_get()$text[["family"]],
#'                   size = theme_get()$text[["size"]] / 2,
#'                   fontface = "italic")
#'
#' \dontrun{
#' ggplot(freqdata, aes(x=value, n=freq)) +
#'     stat_lorenz() +annotate_ineq(freqdata$val, freqdata$freq)}
#'
#' @export

annotate_ineq <- function(data_ineq, freq_ineq=rep(1, length(data_ineq)), x = 0.1, y = 0.95, decimals = 2,
                          measure_ineq = 'Gini', sep_ineq = ': ', ...) {

    stat_ineq <- round(ineq::ineq(rep.int(data_ineq, freq_ineq), type=measure_ineq), decimals)
    ggplot2::annotate('text', x, y,
                      label = paste(measure_ineq, stat_ineq, sep = sep_ineq),
                      ...)

}
