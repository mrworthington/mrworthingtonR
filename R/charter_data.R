#' Longitudinal Database of Texas Charter School Enrollment + Financials.
#'
#' This dataset was built using two datasets from the Texas Education Agency (TEA). One source is the [Public Education Information Management System (PEIMS) Single File Financial Data Downloads](https://tea.texas.gov/finance-and-grants/state-funding/state-funding-reports-and-data/peims-single-file-financial-data-downloads), which contains links to each of the Charter School Actual Financials Data between SY1999-2000 and SY2020-2021. The other dataset is the 2007-2021 Summarized PEIMS Actual Financial Data, which contains actual financial data for all school districts (ISDs, Military ISDs, + Charters) from 2006-2007 to 2020-2021. The individual years charter actual financial datasets were used to identify charters in each school year. They were cross linked with the broader summarized PEIMS actual financials.
#'
#' @note **CMO Classification** was done based off current year enrollment counts. Charter Management Organizations (CMOs) with enrollments greater than 10,000 were classified. Charters with less than 10,000 were labeled "Non-Major CMOs". All n values are included in summary aggregates under the `dist_count` column.
#'
#' @format A tibble with 9,161 rows and 13 variables:
#' \describe{
#'   \item{year}{The year end of a school year. For example, 2021 refers to SY2020-2021.}
#'   \item{cmo_class}{The Classification of Major CMOs. See note above on CMO classification.}
#'   \item{dist_count}{The n value for districts represented in each aggregate calculation.}
#'   \item{fall_enrollment}{The aggregate fall enrollment value for each CMO class.}
#'   \item{fund_name}{The fund name recorded by the Texas Education Agency}
#'   \item{amt_total}{The aggregated fund name's total amount.}
#'   \item{amt_per_pupil}{The aggregated fund name's total amount, per pupil.}
#'   \item{amt_dist}{The aggregated fund name's total amount, per n value in `dist_count`.}
#' }
#' @source {[Public Education Information Management System (PEIMS) Single File Financial Data Downloads](https://tea.texas.gov/finance-and-grants/state-funding/state-funding-reports-and-data/peims-single-file-financial-data-downloads): This page provides information and links regarding the Public Education Information Management System (PEIMS) budget and actual financial data. These single data (.csv) files need to be imported into a database that can handle approximately 985,000 rows of data or more. Older versions of Microsoft Excel have size limitations of approximately 65,000 rows.).}
#' @source {[TEA's Summarized PEIMS Actual Financial Data, 2007-2021](https://tea.texas.gov/finance-and-grants/state-funding/state-funding-reports-and-data/peims-financial-data-downloads): This Excel spreadsheet (.xlsx) has PEIMS actual financial data from 2006-2007 to 2020-2021.}
"charter_data"
