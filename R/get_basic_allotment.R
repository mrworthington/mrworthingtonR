#' Get Historic Basic Allotment Data
#'
#' The basic allotment is the legislatively mandated apportionment of funds from the general revenue funds that goes to each school district to provide a basic level of education for the district’s residents. This data is based on recorded data found in the following [PDF provided by the Texas Education Agency](https://tea.texas.gov/sites/default/files/basic-allotment-one-pager.pdf). It represents the annual basic allotment figures for each school year, starting in 2010.
#'
#' @return a tbl_df object
#' @export
#'
#' @source {[Basic Allotment Explainer, Texas Education Agency](https://tea.texas.gov/sites/default/files/basic-allotment-one-pager.pdf). State Funding Division, (512) 463-9238 or sfinance@tea.texas.gov}
#'
#' @examples
#' library(mrworthingtonR)
#' library(dplyr)
#' ba_df <- get_ba() |>
#'   glimpse()
#'
get_ba <- function() {

  tibble::tibble(year = c("2010","2011","2012","2013","2014","2015","2016",
                           "2017","2018","2019","2020","2021","2022"),
                  basic_allotment = c(4765,4765,4765,4765,4950,5040,5140,5140,
                                      5140,6160,6160,6160,6160))

}
