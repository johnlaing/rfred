## basic settings
fred <- function(api_key, file_type="xml", processor=guess.processor(file_type), ...) {
    structure(list(
        base.url="http://api.stlouisfed.org",
        processor=processor,
        params=c(api_key=api_key, file_type=file_type, ...)),
    class="fred")
}

guess.processor <- function(file_type) {
    if (file_type == "xml") basic.xml.processor else anti.processor
}


## interface to webservices API
get.fred <- function(f, url, options=c()) {
    if (length(options) & (is.null(names(options)) | any(names(options) == "")))
        stop("options must be named")
    options <- c(f$params, options)
    opt.str <- paste(names(options), options, sep="=", collapse="&")

    conn <- url(sprintf("%s/%s?%s", f$base.url, url, opt.str))
    raw <- readLines(conn, warn=FALSE)
    close(conn)
    f$processor(raw, url, options)
}

anti.processor <- function(xml, url, options) return(xml)

basic.xml.processor <- function(xml, url, options) {
    require(XML)
    r <- xmlRoot(xmlTreeParse(xml, asText=TRUE))
    att <- lapply(xmlChildren(r), function(x) {
        a <- xmlAttrs(x)
        if (length(v <- xmlValue(x))) {
            names(v) <- xmlName(x)
            a <- c(a, v)
        }
        a
    })
    cn <- unique(unlist(lapply(att, names)))

    ans <- data.frame(row.names=seq(length(att)))
    for (x in cn) ans[, x] <- type.convert(sapply(att, function(a) a[x]), as.is=TRUE)
    attr(ans, "metadata") <- xmlAttrs(r)
    ans
}

