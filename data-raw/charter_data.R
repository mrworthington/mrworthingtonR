## code to prepare `charter_data` dataset goes here
library(tidyverse)
library(janitor)
library(rvest)

charter_links <- tibble(sy_ending = c("2000",
                                      "2001",
                                      "2002",
                                      "2003",
                                      "2004",
                                      "2005",
                                      "2006",
                                      "2007",
                                      "2008",
                                      "2009",
                                      "2010",
                                      "2011",
                                      "2012",
                                      "2013",
                                      "2014",
                                      "2015",
                                      "2016",
                                      "2017",
                                      "2018",
                                      "2019",
                                      "2020",
                                      "2021"
),
                       link = c("https://rptsvr1.tea.texas.gov/school.finance/forecasting/downloads/Actual_Singlefile/CharAct00.csv",
                                "https://rptsvr1.tea.texas.gov/school.finance/forecasting/downloads/Actual_Singlefile/CharAct01.csv",
                                "https://rptsvr1.tea.texas.gov/school.finance/forecasting/downloads/Actual_Singlefile/CharAct02.csv",
                                "https://rptsvr1.tea.texas.gov/school.finance/forecasting/downloads/Actual_Singlefile/CharAct03.csv",
                                "https://rptsvr1.tea.texas.gov/school.finance/forecasting/downloads/Actual_Singlefile/CharAct04.csv",
                                "https://rptsvr1.tea.texas.gov/school.finance/forecasting/downloads/Actual_Singlefile/CharAct05.csv",
                                "https://rptsvr1.tea.texas.gov/school.finance/forecasting/downloads/Actual_Singlefile/CharAct06.csv",
                                "https://rptsvr1.tea.texas.gov/school.finance/forecasting/downloads/Actual_Singlefile/CharAct07.csv",
                                "https://rptsvr1.tea.texas.gov/school.finance/forecasting/downloads/Actual_Singlefile/CharAct08.csv",
                                "https://rptsvr1.tea.texas.gov/school.finance/forecasting/downloads/Actual_Singlefile/CharAct09.csv",
                                "https://rptsvr1.tea.texas.gov/school.finance/forecasting/downloads/Actual_Singlefile/CharAct10.csv",
                                "https://rptsvr1.tea.texas.gov/school.finance/forecasting/downloads/Actual_Singlefile/CharAct11.csv",
                                "https://tea.texas.gov/WorkArea/linkit.aspx?LinkIdentifier=id&ItemID=25769804136",
                                "https://tea.texas.gov/WorkArea/linkit.aspx?LinkIdentifier=id&ItemID=25769810373",
                                "https://tea.texas.gov/WorkArea/linkit.aspx?LinkIdentifier=id&ItemID=25769820606",
                                "https://tea.texas.gov/WorkArea/linkit.aspx?LinkIdentifier=id&ItemID=25769825544",
                                "https://tea.texas.gov/sites/default/files/CharAct16.zip",
                                "https://tea.texas.gov/sites/default/files/CharAct17.zip",
                                "https://tea.texas.gov/sites/default/files/CharAct18.zip",
                                "https://tea.texas.gov/sites/default/files/charact19.zip",
                                "https://tea.texas.gov/sites/default/files/charact20.zip",
                                "https://tea.texas.gov/sites/default/files/charact21.zip")) |>
  mutate(year = str_remove_all(sy_ending, "^20"))


# Download CSV files ------------------------------------------------------

charter_csvs <- charter_links |>
  filter(!str_detect(link, "zip"))

map2(charter_csvs$year,charter_csvs$link,
    ~download.file(.y, destfile = paste0("data-raw/charter_actuals/CharAct",.x, ".csv")))

# Download Zipped Files ---------------------------------------------------

charter_zips <- charter_links |>
  filter(str_detect(link, "zip")) |>
  mutate(destfile = str_remove_all(link, "https://tea.texas.gov/sites/default/files/"))

map(charter_zips$destfile,
      ~download.file(paste0("https://tea.texas.gov/sites/default/files/", .x), destfile = paste0("data-raw/charter_actuals/zips/",.x)))

map(charter_zips$destfile,
    ~unzip(zipfile = paste0("data-raw/charter_actuals/zips/",.x), exdir = "data-raw/charter_actuals/"))


# Merge All Data Into One -------------------------------------------------

file_ls <- fs::dir_ls("data-raw/charter_actuals", glob = "*.csv") |>
  as_tibble() |>
  filter(!str_detect(value, "Charter Locator Map.csv")) |>
  pull(value)

chart_actuals_raw <- map2(file_ls, charter_links$sy_ending,
                          ~read_csv(.x) |>
                            mutate(year = .y)) |>
  list_rbind() |>
  clean_names()

charters_unique <- chart_actuals_raw |>
  distinct(district)

# Combine with Summary of School Finances ---------------------------------

# charter_schools <- read_csv("data-raw/charter_actuals/Charter Locator Map.csv")

idea_ids <- read_excel("data-raw/2007-2021-summaried-peims-financial-data.xlsx") |>
  clean_names() |>
  rename(district=district_number) |>
  mutate(district = str_remove_all(district, "'")) |>
  filter(str_detect(district_name, "^IDEA")) |>
  distinct(district) |>
  pull(district) |>
  paste(collapse="|")

kipp_ids <- read_excel("data-raw/2007-2021-summaried-peims-financial-data.xlsx") |>
  clean_names() |>
  rename(district=district_number) |>
  mutate(district = str_remove_all(district, "'")) |>
  filter(str_detect(district_name, "KIPP")) |>
  distinct(district) |>
  pull(district) |>
  paste(collapse="|")

responsive_ids <- read_excel("data-raw/2007-2021-summaried-peims-financial-data.xlsx") |>
  clean_names() |>
  rename(district=district_number) |>
  mutate(district = str_remove_all(district, "'")) |>
  filter(str_detect(district_name, "PREMIER HIGH SCHOOLS|TEXAS COLLEGE PREPARATORY|EAGLE ACADEMIES OF TEXAS|RESPONSIVE EDUCATION SOLUTIONS")) |>
  distinct(district) |>
  pull(district) |>
  paste(collapse="|")

harmony_ids <- read_excel("data-raw/2007-2021-summaried-peims-financial-data.xlsx") |>
  clean_names() |>
  rename(district=district_number) |>
  mutate(district = str_remove_all(district, "'")) |>
  filter(str_detect(district_name, "^HARMONY") & !str_detect(district_name, "ISD")) |>
  distinct(district) |>
  pull(district) |>
  paste(collapse="|")

yes_prep_ids <- read_excel("data-raw/2007-2021-summaried-peims-financial-data.xlsx") |>
  clean_names() |>
  rename(district=district_number) |>
  mutate(district = str_remove_all(district, "'")) |>
  filter(str_detect(district_name, "YES PREP")) |>
  distinct(district) |>
  pull(district) |>
  paste(collapse="|")

uplift_ids <- read_excel("data-raw/2007-2021-summaried-peims-financial-data.xlsx") |>
  clean_names() |>
  rename(district=district_number) |>
  mutate(district = str_remove_all(district, "'")) |>
  filter(str_detect(district_name, "UPLIFT")) |>
  distinct(district) |>
  pull(district) |>
  paste(collapse="|")

ilt_ids <- read_excel("data-raw/2007-2021-summaried-peims-financial-data.xlsx") |>
  clean_names() |>
  rename(district=district_number) |>
  mutate(district = str_remove_all(district, "'")) |>
  filter(str_detect(district_name, "INTERNATIONAL LEADERSHIP OF TEXAS")) |>
  distinct(district) |>
  pull(district) |>
  paste(collapse="|")

charter_data <- read_excel("data-raw/2007-2021-summaried-peims-financial-data.xlsx") |>
  clean_names() |>
  rename(district=district_number) |>
  mutate(district = str_remove_all(district, "'"),
         charter_status = if_else(district %in% charters_unique$district,
                                  "Yes",
                                  "No")) |>
  filter(charter_status == "Yes") |>
  select(year, district, district_name, fall_enrollment = fall_survey_enrollment, gen_funds_total_rev = gen_funds_total_operating_revenue_and_other_revenue_and_recpatur, all_funds_total_rev = all_funds_total_operating_revenue_and_other_revenue_and_recpatur, gen_funds_total_disbursements, all_funds_total_disbursements) |>
  mutate(cmo_class = case_when(
    str_detect(district, harmony_ids) ~ "Harmony",
    str_detect(district, kipp_ids) ~ "KIPP Texas",
    str_detect(district, responsive_ids) ~ "ResponsiveEd",
    str_detect(district, idea_ids) ~ "IDEA",
    str_detect(district, uplift_ids) ~ "Uplift",
    str_detect(district, yes_prep_ids) ~ "Yes Prep",
    str_detect(district, ilt_ids) ~ "Intl. Leadership",
    TRUE ~ "Non-Major CMO"
  )) |>
  group_by(year, cmo_class) |>
  summarise(dist_count = n_distinct(district),
            fall_enrollment = sum(fall_enrollment),
            gen_funds_total_rev = sum(gen_funds_total_rev),
            all_funds_total_rev = sum(all_funds_total_rev),
            gen_funds_total_disbursements = sum(gen_funds_total_disbursements),
            all_funds_total_disbursements = sum(all_funds_total_disbursements)) |>
  pivot_longer(cols = starts_with(c("gen_funds", "all_funds")),
               names_to = "fund_name",
               values_to = "amt_total") |>
  # filter(fund_name == "all_funds_total_rev") |>
  mutate(amt_per_pupil = amt_total/fall_enrollment) |>
  mutate(amt_dist = amt_total/dist_count) |>
  arrange(desc(year)) |>
  glimpse()

usethis::use_data(charter_data, overwrite = TRUE)
