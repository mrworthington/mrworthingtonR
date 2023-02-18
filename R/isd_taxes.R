#' Longitudinal Database of Texas School District Property Values and Tax Rates.
#'
#' This dataset comes from the Texas Education Agency (TEA). It includes data recorded
#' at the bottom of each ISD's Public Education Information Management System (PEIMS)
#' Financial Actual Reports.
#'
#' @format A tibble with 9,161 rows and 13 variables:
#' \describe{
#'   \item{year}{The year end of a school year. For example, 2013 refers to SY2012-2013.}
#'   \item{dist_id}{The District ID Assigned by the Texas Education Agency}
#'   \item{dist_name}{The District Name as Recognized by the Texas Education Agency}
#'   \item{m_o_tax_rate}{The Maintenance & Operations (M&O) Tax Rate for the year end recorded.}
#'   \item{i_s_tax_rate}{The Interest & Sinking (I&S) Tax Rate for the year end recorded.}
#'   \item{total_tax_rate}{The Total Tax Rate (M&O + I&S) for the year end recorded.}
#'   \item{total_property_value}{The year end's Certified Total Property Values Used by TEA}
#'   \item{total_property_value_per_pupil}{The year end's Certified Total Property Values Used by TEA, Per Pupil}
#'   \item{business_property_value}{The year end's Certified Business Property Values Used by TEA}
#'   \item{residential_property_value}{The year end's Certified Residential Property Values Used by TEA}
#'   \item{land_property_value}{The year end's Certified Land Property Values Used by TEA}
#'   \item{oil_and_gas_property_value}{The year end's Certified Oil + Gas Property Values Used by TEA}
#'   \item{other_property_value}{The year end's Certified Other Property Values Used by TEA}
#' }
#' @source {[TEA's ISD Tax Rates and State Certified Property Values Data for All Texas School Districts, SY2012-2013](https://tea.texas.gov/sites/default/files/tax_data_13.xlsx): ISD Tax Rates and State Certified Property Values, via Texas Education Agency's Public Education Information Management System (PEIMS).}
#' @source {[TEA's ISD Tax Rates and State Certified Property Values Data for All Texas School Districts, SY2013-2014](https://tea.texas.gov/sites/default/files/tax_data_14.xlsx): ISD Tax Rates and State Certified Property Values, via Texas Education Agency's Public Education Information Management System (PEIMS).}
#' @source {[TEA's ISD Tax Rates and State Certified Property Values Data for All Texas School Districts, SY2014-2015](https://tea.texas.gov/sites/default/files/tax_data_15.xlsx): ISD Tax Rates and State Certified Property Values, via Texas Education Agency's Public Education Information Management System (PEIMS).}
#' @source {[TEA's ISD Tax Rates and State Certified Property Values Data for All Texas School Districts, SY2015-2016](https://tea.texas.gov/sites/default/files/tax_data_16.xlsx): ISD Tax Rates and State Certified Property Values, via Texas Education Agency's Public Education Information Management System (PEIMS).}
#' @source {[TEA's ISD Tax Rates and State Certified Property Values Data for All Texas School Districts, SY2016-2017](https://tea.texas.gov/sites/default/files/tax_data_17.xlsx): ISD Tax Rates and State Certified Property Values, via Texas Education Agency's Public Education Information Management System (PEIMS).}
#' @source {[TEA's ISD Tax Rates and State Certified Property Values Data for All Texas School Districts, SY2017-2018](https://tea.texas.gov/sites/default/files/tax_data_18.xlsx): ISD Tax Rates and State Certified Property Values, via Texas Education Agency's Public Education Information Management System (PEIMS).}
#' @source {[TEA's ISD Tax Rates and State Certified Property Values Data for All Texas School Districts, SY2018-2019](https://tea.texas.gov/sites/default/files/tax_data_19.xlsx): ISD Tax Rates and State Certified Property Values, via Texas Education Agency's Public Education Information Management System (PEIMS).}
#' @source {[TEA's ISD Tax Rates and State Certified Property Values Data for All Texas School Districts, SY2019-2020](https://tea.texas.gov/sites/default/files/tax_data_20.xlsx): ISD Tax Rates and State Certified Property Values, via Texas Education Agency's Public Education Information Management System (PEIMS).}
#' @source {[TEA's ISD Tax Rates and State Certified Property Values Data for All Texas School Districts, SY2020-2021](https://tea.texas.gov/sites/default/files/tax_data_21.xlsx): ISD Tax Rates and State Certified Property Values, via Texas Education Agency's Public Education Information Management System (PEIMS).}
"tea_isd_tax_data"
