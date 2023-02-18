## code to prepare `tea_isd_tax_data` dataset goes here
library(tidyverse)
library(janitor)
library(readxl)
library(rvest)
library(xml2)

year_start <- 13:21 |>
  as.character() |>
  simplify()

get_dist_tax_data <- function(year) {

  url <- paste0("https://tea.texas.gov/sites/default/files/tax_data_",year,".xlsx")

  download.file(url, destfile = paste0("data-raw/tea_tax_files/tax_data_20",year,".xlsx"))

  Sys.sleep(2)

}

map(year_start,
       ~get_dist_tax_data(.x))

files <- fs::dir_ls("data-raw/tea_tax_files/") |>
  simplify()

tea_isd_tax_data <- map_df(files,
                       ~read_excel(.x, skip = 1) |>
                         mutate(across(everything(), ~as.character(.))) |>
                         mutate(across(contains("Value"), ~as.numeric(.))) |>
                         mutate(across(everything("Rate"), ~as.numeric(.))) |>
                         mutate(file = .x,
                                file = str_remove_all(file, "data-raw/tea_tax_files/tax_data_|.xlsx"))) |>
  select(year = file, dist_id=1, dist_name = 2, everything()) |>
  clean_names()

usethis::use_data(tea_isd_tax_data, overwrite = TRUE)
