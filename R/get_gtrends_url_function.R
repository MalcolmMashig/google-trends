get_gtrends_url <- function(start_date, end_date, country, search_terms) {
  search_terms <- gsub(" ", "%20", search_terms)
  search_terms <- gsub('"', "%22", search_terms)
  str_c(
    str_c(
      "https://trends.google.com/trends/explore?date=",
      start_date,
      "%20",
      end_date,
      "&geo=",
      country,
      "&q="
    ),
    str_c(
      search_terms[1],
      if(length(search_terms) >= 2) {search_terms[2]},
      if(length(search_terms) >= 3) {search_terms[3]},
      if(length(search_terms) >= 4) {search_terms[4]},
      if(length(search_terms) >= 5) {search_terms[5]},
      sep = ","
    )
  )
}
