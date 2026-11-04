rcd_tagged_na_dbl <- function(df, vars_dbl){
  
  df %>% 
    mutate(
      across(
          {{vars_dbl}},
          ~ replace_when(
            .x,
            .x >= 0 ~ .x,
            .x == -1 ~ tagged_na("a"),
            .x == -2 ~ tagged_na("b"),
            .x == -8 ~ tagged_na("c"),
            .x == -9 ~ tagged_na("d")
          )
        )
      )
}