 etiquettes_repeted <- function(df, suffix, avant_n, post_n){
    vars_repeted <- select({{df}}, ends_with({{suffix}})) %>% names()
    
    if (length(vars_repeted) < 1){
      stop(paste("suffix", {{suffix}}, "invalide"))
    }

    num_obs <- str_extract(vars_repeted, "(?<=enf|cpl|frt0)\\d+")
    labels_repeted <- set_names(paste0({{avant_n}}, num_obs, {{post_n}}), vars_repeted)
    
    {{df}} %>% 
      set_variable_labels(., !!!labels_repeted)

  }