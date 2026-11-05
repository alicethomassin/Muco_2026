lbl_QCM <- function(df, var_qcm){
  df %>% 
  add_value_labels(
    {{var_qcm}} := c(
      "Selected" = 1,
      "Not selected" = 0
    )
  )
}