#' Get counts of the number of records per index
#'
#' @export
#' @param conn an Elasticsearch connection object, see [connect()]
#' @param index Index, defaults to all indices
#' @param type Document type, optional
#' @param callopts Curl args passed on to [crul::verb-GET]
#' @param verbose If `TRUE` (default) the url call used printed to console.
#' @param ... Further args passed on to elastic search HTTP API as parameters.
#' @details See docs for the count API here
#' <https://www.elastic.co/guide/en/elasticsearch/reference/current/search-count.html>
#' 
#' You can also get a count of documents using [Search()] or 
#' [Search_uri()] and setting `size = 0`
#' @examples \dontrun{
#' # connection setup
#' (x <- connect())
#' 
#' if (!index_exists(x, "plos")) {
#'   plosdat <- system.file("examples", "plos_data.json",
#'     package = "elastic")
#'   plosdat <- type_remover(plosdat)
#'   invisible(docs_bulk(x, plosdat))
#' }
#' if (!index_exists(x, "shakespeare")) {
#'   shake <- system.file("examples", "shakespeare_data_.json", 
#'     package = "elastic")
#'   invisible(docs_bulk(x, shake))
#' }
#' 
#' count(x)
#' count(x, index='plos')
#' count(x, index='shakespeare')
#' count(x, index=c('plos','shakespeare'), q="a*")
#' count(x, index=c('plos','shakespeare'), q="z*")
#'
#' # Curl options
#' count(x, callopts = list(verbose = TRUE))
#' }

count <- function(conn, index=NULL, type=NULL, callopts=list(), 
  verbose=TRUE, ...) {

  is_conn(conn)
  out <- es_GET(conn, path = '_count', cl(index), type, 
    NULL, NULL, NULL, FALSE, callopts, ...)
  jsonlite::fromJSON(out, FALSE)$count
}
