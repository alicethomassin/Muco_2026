lbl_oui_non <- function(df, var_bin){
  
  df %>% 
    add_value_labels(
      {{var_bin}} := c(
        "Yes" = 1
        "No" = 0
      )
    )
}