
#' Values of Generalized Lorenz Curve
#'
#' Provides generalized Lorenz curve values for line plots
#'
#' @md
#' @inheritParams ggplot2::geom_path
#' @param geom which geom to use; defaults to "`path`".
#' @references
#'   [Lorenz curve from Wikipedia](https://en.wikipedia.org/wiki/Lorenz_curve)
#' @importFrom ggplot2 layer
#' @export
#' @examples
#' \dontrun{
#' library(gglorenz)
#'
#' ggplot(billionaires, aes(TNW)) +
#'     stat_lorenz_generalized()
#' }
stat_lorenz_generalized <-
    function(mapping = NULL, data = NULL,
             geom = "path", position = "identity",
             ...,
             show.legend = NA,
             inherit.aes = TRUE) {
    layer(
        data = data,
        mapping = mapping,
        stat = StatLorenzGeneralized,
        geom = geom,
        position = position,
        show.legend = show.legend,
        inherit.aes = inherit.aes,
        params = list(
            ...
        )
    )
}

#' @rdname gglorenz-package
#' @format NULL
#' @usage NULL
#' @importFrom ggplot2 ggproto Stat
#' @importFrom ineq Lc
#' @export
StatLorenzGeneralized <-
    ggproto("StatLorenzGeneralized", Stat,
            default_aes = aes(x = calc(x),
                              y = calc(generalized_Lorenz_curve)),
            required_aes = c("x"),
            compute_group = function(data, scales) {

                if (any(data$x < 0)) {
                    stop("stat_lorenz() requires a vector containing
                         non-negative elements.", call. = FALSE)
                    }

                Lc <- ineq::Lc(data$x)
                data.frame(x = Lc$p, generalized_Lorenz_curve = Lc$L.general)
            }
    )
