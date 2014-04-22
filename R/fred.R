## basic settings
fred <- function(api.key) {
    structure(list(
        base.url="http://api.stlouisfed.org",
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
    attr(ans, "metadata") <- xmlAttrs(r)
    ans
}

