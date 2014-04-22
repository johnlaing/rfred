## basic settings
fred <- function(api.key) {
    structure(list(
        base.url="http://api.stlouisfed.org/fred",
        api.key =api.key),
    class="fred")
}


## interface to webservices API
get.fred <- function(f, url, options=c()) {
    options["api_key"] <- f$api.key
    opt.str <- paste(names(options), options, sep="=", collapse="&")
    xmlTreeParse(sprintf("%s/%s?%s", f$base.url, url, opt.str))
}

process.fred <- function(xml) {
    r <- xmlRoot(xml)
    att <- lapply(xmlChildren(r), xmlAttrs)
    cn <- unique(unlist(lapply(att, names)))

    ans <- data.frame(row.names=seq(length(att)))
    for (x in cn) ans[, x] <- type.convert(sapply(att, function(a) a[x]), as.is=TRUE)
    ans
}


## data functions

## categories
fred.category <- function(f, category_id=NULL) {
    x <- get.fred(f, "category", c(category_id=category_id))
    process.fred(x)
}

fred.category.children <- function(f, category_id=NULL, realtime_start=NULL, realtime_end=NULL) {
    x <- get.fred(f, "category/children", c(category_id=category_id, realtime_start=realtime_start, realtime_end=realtime_end))
    process.fred(x)
}

fred.category.related <- function(f, category_id, realtime_start=NULL, realtime_end=NULL) {
    x <- get.fred(f, "category/related", c(category_id=category_id, realtime_start=realtime_start, realtime_end=realtime_end))
    process.fred(x)
}

fred.category.series <- function(...) stop("not implemented")
fred.category.tags <- function(...) stop("not implemented")
fred.category.related_tags <- function(...) stop("not implemented")
