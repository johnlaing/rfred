## basic settings
fred <- function(api_key, file_type="json", processor=guess.processor(file_type), ...) {
    structure(list(
        base.url="http://api.stlouisfed.org",
        processor=processor,
        params=c(api_key=api_key, file_type=file_type, ...)),
    class="fred")
}

guess.processor <- function(file_type) {
    switch(file_type,
        json=smart.json.processor,
        xml=smart.xml.processor,
        NULL)
}


## interface to webservices API
get.fred <- function(f, url, options=c(), processor=f$processor) {
    if (length(options) & (is.null(names(options)) | any(names(options) == "")))
        stop("options must be named")
    exp.options <- c(f$params, options)
    opt.str <- paste(names(exp.options), exp.options, sep="=", collapse="&")

    conn <- url(sprintf("%s/%s?%s", f$base.url, url, opt.str))
    raw <- readLines(conn, warn=FALSE)
    close(conn)
    if (!is.null(processor)) processor(raw, url, options) else raw
}

basic.xml.processor <- function(res, url, options) {
    require(XML)
    r <- xmlRoot(xmlTreeParse(res, asText=TRUE))
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
    for (x in cn) ans[, x] <- type.convert(sapply(att, function(a) a[x]), na.strings=c("NA", "."), as.is=TRUE)
    attr(ans, "metadata") <- as.list(xmlAttrs(r))
    ans
}

smart.xml.processor <- function(res, url, options) {
    require(zoo)
    ans <- basic.xml.processor(res, url, options)
    meta <- attr(ans, "metadata")

    ## remove columns that just duplicate metadata
    for (n in intersect(names(ans), names(meta))) {
        if (all(ans[, n] == meta[[n]])) ans[, n] <- NULL
    }

    ## scrub date/time
    scrub <- function(x) {
        if (is.character(x)) {
            date.pattern <- "^[0-9]{4}-[0-9]{2}-[0-9]{2}$"
            time.pattern <- "^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}-[0-9]{2}$"
            if (all(grepl(date.pattern, x))) x <- as.Date(x)
            if (all(grepl(time.pattern, x))) x <- as.POSIXct(x)
        }
        x
    }
    ans[] <- lapply(ans, scrub)
    meta <- lapply(meta, scrub)

    ## special cases
    if (url == "fred/series/observations") {
        ans <- zoo(ans$value, ans$date)
    }
    attr(ans, "metadata") <- meta
    return(ans)
}

basic.json.processor <- function(res, url, options) {
    require(jsonlite)
    r <- fromJSON(res)
    att <- r[-length(r)]
    ans <- r[[length(r)]]
    attr(ans, "metadata") <- att
    ans
}

smart.json.processor <- function(res, url, options) {
    require(zoo)
    ans <- basic.json.processor(res, url, options)
    meta <- attr(ans, "metadata")

    ## remove columns that just duplicate metadata
    for (n in intersect(names(ans), names(meta))) {
        if (all(ans[, n] == meta[[n]])) ans[, n] <- NULL
    }

    ## scrub date/time
    scrub <- function(x) {
        if (is.character(x)) {
            date.pattern <- "^[0-9]{4}-[0-9]{2}-[0-9]{2}$"
            time.pattern <- "^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}-[0-9]{2}$"
            if (all(grepl(date.pattern, x))) x <- as.Date(x)
            if (all(grepl(time.pattern, x))) x <- as.POSIXct(x)
        }
        x
    }
    ans[] <- lapply(ans, scrub)
    meta <- lapply(meta, scrub)

    ## special cases
    if (url == "fred/series/observations") {
        ans <- zoo(ans$value, ans$date)
    }
    attr(ans, "metadata") <- meta
    return(ans)
}
