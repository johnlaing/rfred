fred.category <- function(f, category_id=NULL) {
    x <- get.fred(f, "fred/category", c(category_id=category_id))
    process.fred(x)
}
fred.category.children <- function(f, category_id=NULL, realtime_start=NULL, realtime_end=NULL) {
    x <- get.fred(f, "fred/category/children", c(category_id=category_id, realtime_start=realtime_start, realtime_end=realtime_end))
    process.fred(x)
}
fred.category.related <- function(f, category_id, realtime_start=NULL, realtime_end=NULL) {
    x <- get.fred(f, "fred/category/related", c(category_id=category_id, realtime_start=realtime_start, realtime_end=realtime_end))
    process.fred(x)
}
fred.category.series <- function(f, category_id, realtime_start=NULL, realtime_end=NULL, limit=NULL, offset=NULL, order_by=NULL, sort_order=NULL, filter_variable=NULL, filter_value=NULL, tag_names=NULL) {
    x <- get.fred(f, "fred/category/series", c(category_id=category_id, realtime_start=realtime_start, realtime_end=realtime_end, limit=limit, offset=offset, order_by=order_by, sort_order=sort_order, filter_variable=filter_variable, filter_value=filter_value, tag_names=tag_names))
    process.fred(x)
}
fred.category.tags <- function(f, category_id, realtime_start=NULL, realtime_end=NULL, tag_names=NULL, tag_group_id=NULL, search_text=NULL, limit=NULL, offset=NULL, order_by=NULL, sort_order=NULL) {
    x <- get.fred(f, "fred/category/tags", c(category_id=category_id, realtime_start=realtime_start, realtime_end=realtime_end, tag_names=tag_names, tag_group_id=tag_group_id, search_text=search_text, limit=limit, offset=offset, order_by=order_by, sort_order=sort_order))
    process.fred(x)
}
fred.category.related_tags <- function(f, category_id, tag_names, realtime_start=NULL, realtime_end=NULL, tag_group_id=NULL, search_text=NULL, limit=NULL, offset=NULL, order_by=NULL, sort_order=NULL) {
    x <- get.fred(f, "fred/category/related_tags", c(category_id=category_id, tag_names=tag_names, realtime_start=realtime_start, realtime_end=realtime_end, tag_group_id=tag_group_id, search_text=search_text, limit=limit, offset=offset, order_by=order_by, sort_order=sort_order))
    process.fred(x)
}
