rcd_levels_na <- function(x){
  
  etiq_na <- c(
    "Not applicable" = tagged_na("a"),
    "Module not completed" = tagged_na("b"),
    "Don't know" = tagged_na("c"),
    "No answer" = tagged_na("d")
  )
  
  etiq <- c(val_labels(x), etiq_na)
  tags_etiq <- na_tag(etiq)
  
  tags_data <- na_tag(x)
  tags_data <- unique(tags_data[!is.na(tags_data)])
  
  garder <- if_else(
    is.na(tags_etiq),
    etiq %in% unclass(x),
    tags_etiq %in% tags_data
  )
  
  labelled(x, labels = etiq[garder], label = var_label(x))
}