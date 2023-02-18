#' Get Inflation Data from the Bureau of Labor Statistics
#'
#' @param index The index you want to pull from the Bureau of Labor Statistics. Options are "cpi" for All Consumers Price Index and "edu" for education + communication index. Default is CPI.
#'
#' @return a tbl_df object
#' @export
#'
#' @examples
#'
#' library(mrworthingtonR)
#' library(dplyr)
#'
#' cpi_raw <- get_inflation("cpi") |>
#'   filter(series_id == "CUSR0000SA0") |>
#'   select(year, period, cpi_value=value)
#'
#' glimpse(cpi_raw)
#'
#' edu_raw <- get_inflation("edu") |>
#'   filter(series_id == "CUSR0000SAE1") |>
#'   select(year, period, ed_value=value)
#'
#' glimpse(edu_raw)
#'
get_inflation <- function(index = "cpi") {

  if(index=="cpi") {

   readr::read_delim("https://download.bls.gov/pub/time.series/cu/cu.data.1.AllItems") |>
      janitor::clean_names() |>
      dplyr::mutate(series_id = stringr::str_squish(series_id),
             year = as.character(year),
             value = stringr::str_squish(value),
             value = as.numeric(value))


  } else {

    readr::read_delim("https://download.bls.gov/pub/time.series/cu/cu.data.17.USEducationAndCommunication") |>
      janitor::clean_names() |>
      dplyr::mutate(series_id = stringr::str_squish(series_id),
             year = as.character(year),
             value = stringr::str_squish(value),
             value = as.numeric(value))

  }

}
