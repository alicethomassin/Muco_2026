rcd_levels_na <- function(df, var){
  
  df %>% 
    set_value_labels(
          {{var}} := c(
            "Not applicable" = tagged_na("a"),
            "Module not completed" = tagged_na("b"),
            "Don't know" = tagged_na("c"),
            "No answer" = tagged_na("d")
          )
      ) %>% 
        drop_unused_value_labels()
}