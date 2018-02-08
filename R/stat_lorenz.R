
#' Values of Ordinary Lorenz Curve
#'
#' Provides ordinary Lorenz curve values for line plots
#'
#' @md
#' @inheritParams ggplot2::geom_path
#' @param geom which geom to use; defaults to "`path`".
#' @param desc If FALSE, the default, population is arranged in a ascending
#'   order along the x-axis. If TRUE, population is arranged in a descending
#'   order.
#' @references
#'   [Lorenz curve from Wikipedia](https://en.wikipedia.org/wiki/Lorenz_curve)
#' @importFrom ggplot2 layer
#' @export
#' @examples
#' library(gglorenz)
#'
#' ggplot(billionaires, aes(TNW)) +
#'     stat_lorenz()
#'
#' ggplot(billionaires, aes(TNW)) +
#'     stat_lorenz(desc = TRUE) +
#'     coord_fixed() +
#'     geom_abline(linetype = "dashed") +
#'     theme_minimal()
stat_lorenz <- function(mapping = NULL, data = NULL,
                        geom = "path", position = "identity",
                        ...,
                        desc = FALSE,
                        show.legend = NA,
                        inherit.aes = TRUE) {
    layer(
        data = data,
        mapping = mapping,
        stat = StatLorenz,
        geom = geom,
        position = position,
        show.legend = show.legend,
        inherit.aes = inherit.aes,
        params = list(
            desc = desc,
            ...
        )
    )
}

#' @rdname gglorenz-package
#' @format NULL
#' @usage NULL
#' @importFrom ggplot2 ggproto Stat
#' @export
StatLorenz <- ggproto("StatLorenz", Stat,
                      default_aes = aes(x = calc(x),
                                        y = calc(ordinary_Lorenz_curve)),
                      required_aes = c("x"),
                      compute_group = function(data, scales, desc = FALSE) {

                          if (any(data$x < 0)) {
                              stop("stat_lorenz() requires a vector containing
                                   non-negative elements.", call. = FALSE)
                          }

                          Lc <- ineq::Lc(data$x)

                          if (desc) {
                              data.frame(x = 1 - Lc$p,
                                         ordinary_Lorenz_curve = 1 - Lc$L)
                          } else {
                              data.frame(x = Lc$p,
                                         ordinary_Lorenz_curve = Lc$L)
                          }
                      }
)
