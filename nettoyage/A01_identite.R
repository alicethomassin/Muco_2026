# 0. Set up ---------------------------------------------------------------
library(tidyverse)
library(questionr)

# Importer la base brute de l'identité
M1_F0 <- haven::read_sas("raw_data/gb_ddb_identite_01.sas7bdat")

vars_id_rmv <- c("id_type", "tab_db")
# 1. Correction classe  ---------------------------------------------------
corr_fact <- c("id_lieu_nais", "id_sexe")
corr_chr <- c("id_centre1", "id_centre2", "id_centre3", "id_dep_nais")

M1_F1 <- M1_F0 %>% 
  haven::zap_label() %>% 
  haven::zap_formats() %>% 
  mutate(across(all_of(corr_fact), as.factor)) %>% 
  mutate(across(all_of(corr_chr), as.character)) %>% 
  mutate(across(
    .cols = where(is.character),
    .fns = ~ na_if(., "")
  )) %>% 
  mutate(
    id_dep_nais = case_when(
      id_lieu_nais == 2 ~ "99",
      TRUE ~ id_dep_nais)
  ) %>% 
  select(-all_of(vars_id_rmv)) %>% 
  relocate(id_sep, .after = id_anonymat) %>% 
  relocate(c("id_nom", "id_nom_jeune", "id_prenom", "id_sexe",
             "id_date_nais", "id_age", "id_lieu_nais", "id_dep_nais"
  ), .after = id_sep) %>% 
  mutate(
    id_centre_suivi = case_when(
      is.na(id_centre1) ~ 0,
      TRUE ~ 1) %>% factor()
  ) %>% 
  relocate(id_centre_suivi, .after = id_dep_nais)

M1_F2 <- M1_F1 %>% 
  mutate(
    id_link = case_when(
      !is.na(id_sep) ~ str_sub(id_sep, 7, 11),
      TRUE ~ id_anonymat),
    id_keep = id_anonymat
  ) %>% 
  relocate(c("id_keep", "id_link"), .after = id_anonymat) %>% 
  select(-id_sep)

# 2. Version longue des données d'identité --------------------------------

write_csv(M1_F2, "clean_data/THOA_idendite_rsv1.csv") 

# write_csv(M1_F2, "clean_data/thoa_M1_L1.csv") Dans celui-ci c'est id_doub et non id_link

registre <- M1_F2 %>% 
  select(id_date_creation:id_link)

write_csv(registre, "clean_data/thoa_registre.csv")
