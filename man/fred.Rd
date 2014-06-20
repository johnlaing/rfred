\name{fred}
\alias{fred}
\alias{fred.category}
\alias{fred.category.children}
\alias{fred.category.related}
\alias{fred.category.series}
\alias{fred.category.tags}
\alias{fred.category.related_tags}
\alias{fred.releases}
\alias{fred.releases.dates}
\alias{fred.release}
\alias{fred.release.dates}
\alias{fred.release.series}
\alias{fred.release.sources}
\alias{fred.release.tags}
\alias{fred.release.related_tags}
\alias{fred.series}
\alias{fred.series.categories}
\alias{fred.series.observations}
\alias{fred.series.release}
\alias{fred.series.search}
\alias{fred.series.search.tags}
\alias{fred.series.search.related_tags}
\alias{fred.series.tags}
\alias{fred.series.updates}
\alias{fred.series.vintagedates}
\alias{fred.sources}
\alias{fred.source}
\alias{fred.source.releases}
\alias{fred.tags}
\alias{fred.related_tags}
\alias{fred.tags.series}
\title{Federal Reserve Economic Data}
\description{
  Provides an interface to the Federal Reserve Economic Database. The database is maintained by the St. Louis Fed, while this package is merely a wrapper around the public API.
  Compulsory disclaimer: this product uses the FRED API but is not endorsed or certified by the Federal Reserve Bank of St. Louis.
}
\usage{
  fred(api_key, file_type="json", processor=guess.processor(file_type), ...)
  fred.category(f, category_id=NULL, ...)
  fred.category.children(f, category_id=NULL, ...)
  fred.category.related(f, category_id, ...)
  fred.category.series(f, category_id, ...)
  fred.category.tags(f, category_id, ...)
  fred.category.related_tags(f, category_id, tag_names, ...)
  fred.releases(f, ...)
  fred.releases.dates(f, ...)
  fred.release(f, release_id, ...)
  fred.release.dates(f, release_id, ...)
  fred.release.series(f, release_id, ...)
  fred.release.sources(f, release_id, ...)
  fred.release.tags(f, release_id, ...)
  fred.release.related_tags(f, release_id, tag_names, ...)
  fred.series(f, series_id, ...)
  fred.series.categories(f, series_id, ...)
  fred.series.observations(f, series_id, ...)
  fred.series.release(f, series_id, ...)
  fred.series.search(f, search_text, ...)
  fred.series.search.tags(f, series_search_text, ...)
  fred.series.search.related_tags(f, series_search_text, tag_names, ...)
  fred.series.tags(f, series_id, ...)
  fred.series.updates(f, ...)
  fred.series.vintagedates(f, series_id, ...)
  fred.sources(f, ...)
  fred.source(f, source_id, ...)
  fred.source.releases(f, source_id, ...)
  fred.tags(f, ...)
  fred.related_tags(f, tag_names, ...)
  fred.tags.series(f, tag_names, ...)
}
\arguments{
  \item{api_key}{An application-specific code assigned by the Fed.}
  \item{file_type}{Data return format, either xml or json. Current default is xml, but this might change in the future.}
  \item{processor}{A function to process data returned via the web service. The default processor for XML creates a simple \code{data.frame}, but other mechanisms might be preferable for different use cases. See \code{\link{smart.xml.processor}}.}
  \item{f}{A structure as returned by the \code{fred} function.}
  \item{category_id, release_id, series_id, source_id}{FRED identifiers for the associated objects.}
  \item{search_text, series_search_text, tag_names}{HTML-escaped search string, or a semicolon-separated list thereof.}
  \item{...}{Additional arguments as detailed in the FRED API docs.}
}
\value{
The \code{fred} function returns a struct containing basic API settings. All other functions rely on the \code{processor} element of their first argument; return types are dependent on that function.
}
\references{
  The official API docs can be found at \url{http://api.stlouisfed.org/docs/fred/}.
  FRED API codes can be obtained from \url{http://api.stlouisfed.org/api_key.html}.
}
