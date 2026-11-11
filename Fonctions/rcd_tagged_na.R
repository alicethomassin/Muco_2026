rcd_tagged_na <- function(df, vars){
  
  df %>% 
    mutate(
      across(
          {{vars}},
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