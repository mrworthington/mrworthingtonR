.onAttach <- function(libname, pkgname) {

  ft_font_dir <- system.file("fonts", "figtree", package="mrworthingtonR")

  if (interactive()) {
    packageStartupMessage(paste0("mrworthingtonR is under *active* development. ",
                                 "See https://github.com/mrworthington/mrworthingtonR for info/news."))
  }

  # Approach taken from @hbrbrthemes package with suggestion by @alexwhan

  if (.Platform$OS.type == "windows")  { # nocov start
    if (interactive()) packageStartupMessage("Registering Windows fonts with R")
    extrafont::loadfonts("win", quiet = TRUE)
  }

  if (getOption("mrworthingtonR.loadfonts", default = FALSE)) {
    if (interactive()) packageStartupMessage("Registering PDF & PostScript fonts with R")
    extrafont::loadfonts("pdf", quiet = TRUE)
    extrafont::loadfonts("postscript", quiet = TRUE)
  } # nocov end

}
