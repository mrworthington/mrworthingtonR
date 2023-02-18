#' Use LP Brand Fonts
#'
#' @param enable enable use of fonts
#'
#' @export
#'
#' @examples \dontrun{
#' library(mrworthingtonR)
#' library(ggplot2)
#' use_lp_fonts()
#'
#' ggplot(mpg) +
#'   aes(x = displ, y = hwy, colour = class) +
#'   geom_point() +
#'   theme_mrw(legend_position = "bottom", base_family = "Figtree") +
#'   labs(title = "This is the title",
#'        subtitle = "This is a compelling subtitle",
#'        caption = "Where We Got The Data From")
#' }
use_custom_fonts <- function(enable=TRUE) {

  if(isTRUE(enable)) {

    if(.Platform$OS.type == "windows") {

      extrafont::font_import()

    } else {

      systemfonts::register_variant(
        name = "Figtree Semibold",
        family = "Figtree",
        weight = "semibold",
        features = systemfonts::font_feature(letters = "stylistic")
      )

      systemfonts::register_variant(
        name = "Figtree Bold",
        family = "Figtree",
        weight = "bold",
        features = systemfonts::font_feature(letters = "stylistic")
      )

    }

    message("Please restart your R Session and load {mrworthington} again in order to use Figtree.")

  }

}

#' Use ggplot2 Theme
#'
#' ggplot2 theme for use by me.
#'
#' @note If planning to use "Figtree", you should download it from Google Fonts and use locally or use the showtext package.
#'
#' @param base_size the base size of text for the plot
#' @param base_family the base font used generally across plot text
#' @param title_size the text size for the plot title
#' @param subtitle_size the text size for the plot subtitle
#' @param caption_size the text size for the plot caption
#' @param legend_position where the legend should be placed
#' @param plot_title_position position of plot title (either "plot" or "panel")
#' @param ... Additional arguments passed to [ggplot2::theme_minimal()]
#'
#' @return a ggplot theme
#' @export
#'
#' @examples
#' library(mrworthingtonR)
#' library(ggplot2)
#'
#' ggplot(mpg) +
#'   aes(x = displ, y = hwy, colour = class) +
#'   geom_point() +
#'   theme_mrw(legend_position = "bottom") +
#'   labs(title = "This is the title",
#'        subtitle = "This is a compelling subtitle",
#'        caption = "Where We Got The Data From")

theme_mrw <- function(base_size=14,base_family = "", title_size=23, subtitle_size=12, caption_size=10, legend_position = "none", plot_title_position = "plot", ...) {

  ggplot2::theme_minimal(base_size = base_size, base_family = base_family, ...) +
    ggplot2::theme(
      plot.margin = ggplot2::margin(t=15, r=15, b=10, l = 15),
      plot.title = ggplot2::element_text(color = "#333f48", face = "bold", size = title_size, margin = ggplot2::margin(b = 5), hjust = 0),
      plot.subtitle = ggplot2::element_text(color = "#bf5700",  size = subtitle_size, margin = ggplot2::margin(b = 25), hjust = 0),
      plot.caption = ggplot2::element_text(size = caption_size, color = "#9cadb7", hjust = 1),
      plot.title.position = plot_title_position,
      legend.position = legend_position,
      strip.text.x = ggplot2::element_text(size = 14, color = "#005f86"),
      panel.grid.major.y = ggplot2::element_line(color="#9cadb7"),
      panel.grid.minor.y = ggplot2::element_line(linetype=2, size=0, color="#9cadb7"),
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.minor.x = ggplot2::element_blank(),
      axis.line.x =  ggplot2::element_line(color="#9cadb7", size=.8),
      axis.title.x = ggplot2::element_text(family=base_family, size=8, color="#9cadb7", hjust=1),
      axis.title.y = ggplot2::element_text(family=base_family, size=8, color="#9cadb7", hjust=1),
      axis.text.x = ggplot2::element_text(color = "#9cadb7", angle = 0, size = 12),
      axis.text.y = ggplot2::element_text(color = "#9cadb7", angle = 0, size = 12),
      axis.ticks.x = ggplot2::element_line(size = .5)
    )

}

#' Add A Logo
#'
#' @param ggplot name of the ggplot object you want to have a logo
#' @param logo_path file path to the logo. Must be a PNG file.
#'
#' @return a patchwork object
#' @export
#'
#' @examples \dontrun{
#' library(mrworthingtonR)
#' library(ggplot2)
#'
#' my_chart <- ggplot(mpg) +
#'   aes(x = displ, y = hwy, colour = class) +
#'   geom_point() +
#'   theme_mrw(legend_position = "none") +
#'   labs(title = "This is the title",
#'        subtitle = "This is a compelling subtitle",
#'        caption = "Where We Got The Data From")
#' logo_chart <- add_logo(my_chart)
#'
#' logo_chart
#' }

add_logo <- function(ggplot = NULL, logo_path = NULL) {

  logo <- png::readPNG(logo_path, native = TRUE)

  ## ADD THE LOGO TO OUR CHART

  ggplot + patchwork::inset_element(logo,
                                     left = 0.006,
                                     right = 0.16,
                                     bottom = 0,
                                     top = 0.08,
                                     align_to = 'full',
                                     on_top = TRUE,
                                     clip=TRUE)

}

#' Import Figtree font for use with ggplot2 Charts
#'
#' Figtree is [licensed](https://github.com/erikdkennedy/figtree/blob/master/OFL.txt) under the Open Font License. You can use them in your products & projects – print or digital, commercial or otherwise. This isn't legal advice, please consider consulting a lawyer and see the full license for all details.
#'
#' There is an option `mrworthington.loadfonts` which -- if set to `TRUE` -- will
#' call `extrafont::loadfonts()` to register non-core fonts with R PDF & PostScript
#' devices. If you are running under Windows, the package calls the same function
#' to register non-core fonts with the Windows graphics device.
#'
#' @md
#' @note This will take care of ensuring PDF/PostScript usage. The location of the
#'   font directory is displayed after the base import is complete. It is highly
#'   recommended that you install them on your system the same way you would any
#'   other font you wish to use in other programs.
#' @export
import_figtree <- function() {

  ft_font_dir <- system.file("fonts", "figtree", package="mrworthingtonR")

  suppressWarnings(suppressMessages(extrafont::font_import(ft_font_dir, prompt=FALSE)))

  message(
    sprintf(
      "You will likely need to install these fonts on your system as well.\n\nYou can find them in [%s]",
      ft_font_dir)
  )

}

#' @rdname Figtree
#' @md
#' @title Figtree font name R variable aliases
#' @description `font_ft` == "`Figtree`"
#' @format length 1 character vector
#' @export
font_ft <- "Figtree"


