#' Annotate ggplot2 chart with inequality metric
#'
#' Adds text annotation to chart with any inequality measure from ineq::ineq
#' Inequality measures include Gini, RS, Atkinson, Theil, Kol, var, square.var, entropy
#'
#' @md
#' @param data_ineq Data to calculate the inequality metric on.
#' @param measure_ineq Name of measure to use; defaults to Gini.
#' @param x annotation x-axis position, default to 0.1.
#' @param y annotation y-axis position, defauls to 0.95.
#' @param decimals number of decimals to show, defaults to 2.
#' @param sep_ineq text separator between annonation label and value.
#' @param ... any additional parameters to ggplot2::annotate().
#'
#' @references
#'   [Gini coefficient from Wikipedia](https://en.wikipedia.org/wiki/wiki/Gini_coefficient)
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
#'     annotate_ineq(billionaires$TNW, measure_ineq='RS', color='red')
#'
#' @export

annotate_ineq <- function(data_ineq, x = 0.1, y = 0.95, decimals = 2,
                          measure_ineq = 'Gini', sep_ineq = ': ', ...) {

    stat_ineq <- round(ineq::ineq(data_ineq, type=measure_ineq), decimals)
    ggplot2::annotate('text', x, y, label = paste(measure_ineq, stat_ineq, sep = sep_ineq), ...)

}

