## generate code for user-facing functions
## to be called from top package directory
## e.g., Rscript generate/parse.outline.R
outline <- readLines("generate/outline.txt")

## check file format
stopifnot(length(outline) %% 4 == 3)
chunks <- seq(1, length(outline), by=4)
stopifnot(grepl("^url: ", outline[chunks]))
stopifnot(grepl("^desc: ", outline[chunks+1]))
stopifnot(grepl("^(req|opt):", outline[chunks+2]))

url <- sub("^url: *", "", outline[chunks])
desc <- sub("^url: *", "", outline[chunks+1])
args <- strsplit(sub("^(req|opt): *", "", outline[chunks+2]), ", *")
opt <- grepl("^opt:", outline[chunks+2])

make.fun <- function(url, args, opt) {
    if (length(args) == 0) {
        sprintf('%s <- function(f, ...) get.fred(f, "%s", c(...))',
                gsub("/", ".", url), url)
    } else if (opt) {
        sprintf('%s <- function(f, %s, ...) get.fred(f, "%s", c(%s, ...))',
                gsub("/", ".", url), paste(args, "NULL", sep="=", collapse=", "),
                url, paste(args, args, sep="=", collapse=", "))
    } else {
        sprintf('%s <- function(f, %s, ...) get.fred(f, "%s", c(%s, ...))',
                gsub("/", ".", url), paste(args, collapse=", "),
                url, paste(args, args, sep="=", collapse=", "))
    }
}
funs <- mapply(make.fun, url, args, opt)
writeLines(funs, "R/user.R")
