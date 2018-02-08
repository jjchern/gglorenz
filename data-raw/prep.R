
# Saving the top 500 billionaires in 2018-02-08 as a tibble ---------------

library(tidyverse)

vars = c(".t-rank" , ".t-name", ".t-nw", ".t-country", ".t-industry")
map_dfc(vars,
        ~xml2::read_html("https://www.bloomberg.com/billionaires/") %>%
            rvest::html_nodes(.x) %>%
            rvest::html_text() %>%
            tibble() %>%
            magrittr::set_colnames(slice(., 1)) %>%
            slice(-1)) %>%
    rename(Total_Net_Worth = `Total net worth`) %>%
    mutate(TNW = parse_number(Total_Net_Worth)) %>%
    print() -> billionaires

devtools::use_data(billionaires, overwrite = TRUE)

library(gglorenz)

ggplot(billionaires, aes(TNW)) +
    stat_lorenz()

ggplot(billionaires, aes(TNW)) +
    stat_lorenz(desc = TRUE) +
    coord_fixed() +
    geom_abline(linetype = "dashed") +
    theme_minimal()
