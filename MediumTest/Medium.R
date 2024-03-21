#' take a Markdown file with multiple figures and converts it to HTML 
#' optionally with or without using `image_number_filter.lua`.
#'
#' @param md_file_path the path of markdown file.
#' @param image_numer_filter whether or not to label images with serial numbers.
#' @return conversion results.
#' @examples
#' markdown2html("example.md", image_numer_filter = TRUE)
#' markdown2html("example.md")
markdown2html <- function(md_file_path, image_numer_filter = FALSE) {
  if (image_numer_filter) {
    output_file_name <- sub(".md$", "_filtered.html", basename(md_file_path))
  } else {
    output_file_name <- sub(".md$", ".html", basename(md_file_path))
  }
  
  tryCatch({
    rmarkdown::pandoc_convert(input = md_file_path, 
                              from = "markdown",
                              to = "html5", 
                              output = output_file_name, 
                              # verbose = TRUE,
                              options = ifelse(image_numer_filter, "--lua-filter=image_numbering_filter.lua", ""))
  
    return(list(success = TRUE, message = "Conversion completed successfully."))
  }, error = function(e) {
    return(list(success = FALSE, message = paste("Conversion failed:", e$message)))
  })
}

setwd("C:\\Users\\phinney\\Desktop\\texor\\MediumTest")
markdown2html("example.md", image_numer_filter = TRUE)
markdown2html("example.md")
