rcd_tagged_na_QCM <- function(df, vars_1_qcm){
  
  df %>% 
    mutate(
      across(
          {{vars_1_qcm}},
          ~ replace_when(
            .x,
            .x == -1 ~ tagged_na("a"),
            .x == -2 ~ tagged_na("b"),
            .x == -8 ~ tagged_na("c"),
            .x == -9 ~ tagged_na("d"),
            .x == -6 ~ tagged_na("e"),
            .x == -7 ~ tagged_na("f")
          )
        )
      ) 
}
