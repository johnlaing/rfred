outline <- readLines("outline.txt")

## check file format
stopifnot(length(outline) %% 5 == 4)
chunks <- seq(1, length(outline), by=5)
stopifnot(grepl("^url: ", outline[chunks]))
stopifnot(grepl("^desc: ", outline[chunks+1]))
stopifnot(grepl("^req:", outline[chunks+2]))
stopifnot(grepl("^opt:", outline[chunks+3]))

url <- sub("^url: *", "", outline[chunks])
desc <- sub("^url: *", "", outline[chunks+1])
req <- strsplit(sub("^req: *", "", outline[chunks+2]), ", *")
opt <- strsplit(sub("^opt: *", "", outline[chunks+3]), ", *")


make.fun <- function(url, req, opt) {
    fun <- c(
        '%s <- function(f, %s) {',
        '    x <- get.fred(f, "%s", c(%s))',
        '    process.fred(x)',
        '}')
    fun[1] <- sprintf(fun[1], gsub("/", ".", url), paste(c(req, paste0(opt, "=NULL")), collapse=", "))
    fun[2] <- sprintf(fun[2], url, paste(c(req, opt), c(req, opt), sep="=", collapse=", "))
    fun
}
funs <- mapply(make.fun, url, req, opt, SIMPLIFY=FALSE)
writeLines(unlist(funs), "R/user.R")
