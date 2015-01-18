library(rmarkdown)
library(knitr)
# Create a .md post from .Rmd file
knit_post(input = './scripts/webscraping.Rmd')

# helper functions
knit_post <- function(input, base.url = "/") {
  knitr::opts_knit$set(base.url = base.url)
  fig.path <- paste0("images/", sub(".Rmd$", "", basename(input)), "/")
  knitr::opts_chunk$set(fig.path = fig.path)
  knitr::opts_chunk$set(fig.cap = "center")
  knitr::render_jekyll()
  knitr::knit(input, envir = parent.frame())
}

