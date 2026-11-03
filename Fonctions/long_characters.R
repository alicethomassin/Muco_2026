# Déterminer s'il y a des colonnes dans lesquelles une réponse est trop longue
long_characters <- function(df){
  
  texte_verifier <- df %>% 
    filter(if_any(where(is.character), ~ str_length(.) > 2045)) %>% 
    select(id_anonymat, where(~ is.character(.x) && any(str_length(.x) > 2045, na.rm = TRUE)))


}