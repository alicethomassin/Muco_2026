# Type de base: 

rcd_tagged_na_1rep <- function(df, vars_1rep){
  
  df %>% 
    mutate(
      across(
          {{vars_1rep}},
          ~ replace_when(
            .x,
            .x == -1 ~ tagged_na("a"),
            .x == -2 ~ tagged_na("b"),
            .x == -8 ~ tagged_na("c"),
            .x == -9 ~ tagged_na("d"),
            .x == -7 ~ tagged_na("f")
          )
        )
      )
}