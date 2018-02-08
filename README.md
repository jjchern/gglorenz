
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/jjchern/gglorenz.svg?branch=master)](https://travis-ci.org/jjchern/gglorenz) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/jjchern/gglorenz?branch=master&svg=true)](https://ci.appveyor.com/project/jjchern/gglorenz)

About `gglorenz`
================

The goal of `gglorenz` is to plot Lorenz Curves with the Blessing of `ggplot2`.

Installation
============

``` r
# install.packages("devtools")
devtools::install_github("jjchern/gglorenz")

# To uninstall the package, use:
# remove.packages("gglorenz")
```

Example
=======

Suppose you have a vector with each element represents the amount the stuff a person produced, and you are interested in knowing how much stuff are produced by the top x% of the people, then the `gglorenz::stat_lorenz(desc = TRUE)` would make a graph for you.

``` r
library(tidyverse)
#> ── Attaching packages ──────────────────────────────────────── tidyverse 1.2.1 ──
#> ✔ ggplot2 2.2.1.9000     ✔ purrr   0.2.4     
#> ✔ tibble  1.4.2          ✔ dplyr   0.7.4     
#> ✔ tidyr   0.7.2          ✔ stringr 1.2.0     
#> ✔ readr   1.1.1.9000     ✔ forcats 0.2.0
#> Warning: package 'tibble' was built under R version 3.4.3
#> ── Conflicts ─────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
library(gglorenz)

billionaires
#> # A tibble: 500 x 6
#>    Rank  Name            Total_Net_Worth Country       Industry      TNW
#>    <chr> <chr>           <chr>           <chr>         <chr>       <dbl>
#>  1 1     Jeff Bezos      $118B           United States Technology  118  
#>  2 2     Bill Gates      $91.3B          United States Technology   91.3
#>  3 3     Warren Buffett  $86.1B          United States Diversified  86.1
#>  4 4     Mark Zuckerberg $74.3B          United States Technology   74.3
#>  5 5     Amancio Ortega  $71.7B          Spain         Retail       71.7
#>  6 6     Bernard Arnault $65.0B          France        Consumer     65.0
#>  7 7     Carlos Slim     $64.7B          Mexico        Diversified  64.7
#>  8 8     Larry Ellison   $54.7B          United States Technology   54.7
#>  9 9     Larry Page      $52.6B          United States Technology   52.6
#> 10 10    Sergey Brin     $51.2B          United States Technology   51.2
#> # ... with 490 more rows

billionaires %>%
    ggplot(aes(TNW)) +
    stat_lorenz(desc = TRUE) +
    coord_fixed() +
    geom_abline(linetype = "dashed") +
    theme_minimal() +
    hrbrthemes::scale_x_percent() +
    hrbrthemes::scale_y_percent() +
    labs(x = "Cumulative Percentage of the Top 500 Billionaires",
         y = "Cumulative Percentage of Total Net Worth",
         title = "Inequality Among Billionaires",
         caption = "Source: https://www.bloomberg.com/billionaires/")
```

<img src="man/figures/README-unnamed-chunk-1-1.png" width="100%" />

``` r

billionaires %>%
    filter(Industry %in% c("Technology", "Real Estate")) %>%
    ggplot(aes(x = TNW, colour = Industry)) +
    stat_lorenz(desc = TRUE) +
    coord_fixed() +
    geom_abline(linetype = "dashed") +
    theme_minimal() +
    hrbrthemes::scale_x_percent() +
    hrbrthemes::scale_y_percent() +
    labs(x = "Cumulative Percentage of Billionaires",
         y = "Cumulative Percentage of Total Net Worth",
         title = "Real Estate is a Relatively Equal Field",
         caption = "Source: https://www.bloomberg.com/billionaires/")
```

<img src="man/figures/README-unnamed-chunk-1-2.png" width="100%" />
