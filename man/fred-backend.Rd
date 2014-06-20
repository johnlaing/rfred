\name{fred-backend}
\alias{get.fred}
\alias{guess.processor}
\alias{basic.json.processor}
\alias{smart.json.processor}
\alias{basic.xml.processor}
\alias{smart.xml.processor}

\title{FRED backend}
\description{
  Backend functions for communicating with the FRED API
}
\usage{
  get.fred(f, url, options=c(), processor=f$processor)
  guess.processor(file_type)
  basic.json.processor(res, url, options)
  smart.json.processor(res, url, options)
  basic.xml.processor(res, url, options)
  smart.xml.processor(res, url, options)
}
\arguments{
  \item{f}{A structure as returned by the \code{fred} function.}
  \item{url}{The API URL to get, relative to the base URL contained in \code{f}.}
  \item{options}{A character vector of options to be appended to the URL.}
  \item{processor}{A function to be called on the data, or \code{NULL} to return the unprocessed response}
  \item{file_type}{Data return format, either xml or json.}
  \item{res}{Text returned by the web service}
}
\details{
  The \code{get.fred} function constructs a URL, gets it, and hands off the response to a processor function. A processor function should take the same arguments as \code{get.fred}, which makes it possible for the processor to differentiate its behavior based on url or options. A few processors are provided (and described below), but other functions tailored to a particular purpose can be plugged in.
  The \code{file_type} option determines the format of the response -- either xml or json -- and of course it only makes sense to use a processor that knows how to handle the specified format. The \code{guess.processor} function takes care of that in the default case by choosing a processor based on file type.
  The \code{basic.json.processor, basic.xml.processor} parse JSON/XML into a \code{data.frame}. It does simple classification via \code{type.convert}, but does not bother with dates or other non-atomic types.
  The \code{smart.xml.processor} extends \code{basic.xml.processor} by doing date/time classification and returning observations as a \code{\link[zoo]{zoo}} object.
  The \code{smart.json.processor} similarly extends \code{basic.json.processor}. Additionally it automatically handles pagination, looking at the request metadata and making additional requests until the total record count is reached. Note that in some cases this may lead to hundreds of thousands of records being retrieved unless a limit is specified explicitly.
}
\value{
The \code{fred} function returns a struct containing basic API settings. All other functions rely on the \code{processor} element of their first argument; return types are dependent on that function.
}
\references{
  The official API docs can be found at \url{http://api.stlouisfed.org/docs/fred/}.
  FRED API codes can be obtained from \url{http://api.stlouisfed.org/api_key.html}.
}
