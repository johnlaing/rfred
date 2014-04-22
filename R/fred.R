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
    attr(ans, "metadata") <- xmlAttrs(r)
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

fred.category.series <- function(f, category_id, realtime_start=NULL, realtime_end=NULL, limit=NULL, offset=NULL, order_by=NULL, sort_order=NULL, filter_variable=NULL, filter_value=NULL, tag_name=NULL) {
    x <- get.fred(f, "category/series", c(category_id=category_id, realtime_start=realtime_start, realtime_end=realtime_end, limit=limit, offset=offset, order_by=order_by, sort_order=sort_order, filter_variable=filter_variable, filter_value=filter_value, tag_name=tag_name))
    process.fred(x)
}

fred.category.tags <- function(f, category_id, realtime_start=NULL, realtime_end=NULL, tag_names=NULL, tag_group_id=NULL, search_text=NULL, limit=NULL, offset=NULL, order_by=NULL, sort_order=NULL) {
    x <- get.fred(f, "category/tags", c(category_id=category_id, realtime_start=realtime_start, realtime_end=realtime_end, tag_names=tag_names, tag_group_id=tag_group_id, search_text=search_text, limit=limit, offset=offset, order_by=order_by, sort_order=sort_order))
    process.fred(x)
}

fred.category.related_tags <- function(f, category_id, tag_names, realtime_start=NULL, realtime_end=NULL, tag_group_id=NULL, search_text=NULL, limit=NULL, offset=NULL, order_by=NULL, sort_order=NULL) {
    x <- get.fred(f, "category/related_tags", c(category_id=category_id, tag_names=tag_names, realtime_start=realtime_start, realtime_end=realtime_end, tag_group_id=tag_group_id, search_text=search_text, limit=limit, offset=offset, order_by=order_by, sort_order=sort_order))
    process.fred(x)
}
