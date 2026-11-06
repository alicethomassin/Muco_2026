rcd_tagged_na_QCM <- function(df, vars_1_qcm){
  
  df %>% 
    mutate(
      none_selected = if_all({{vars_1_qcm}}, ~ .x %in% -9)
    ) %>% 
    mutate(
      across(
          {{vars_1_qcm}},
          ~ replace_when(
            .x,
            .x == -1 ~ tagged_na("a"),
            .x == -2 ~ tagged_na("b"),
            .x == -8 ~ tagged_na("c"),
            none_selected  ~ tagged_na("e")
          )
        )
      ) %>% 
        select(-none_selected)
}
