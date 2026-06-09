# 0. Set up ---------------------------------------------------------------
library(tidyverse)
library(questionr)

# Importer la base brute de l'identité
M1_F0 <- haven::read_sas("raw_data/gb_ddb_identite_01.sas7bdat")

# Retirer les formats et labels qui viennent du précédent traitement avec SAS
# Je l'ai enlevé juste parce que je ne sais pas à quoi ça peut me servir et 
# j'ai peur qu'à un moment je sois bloquée parce qu'il y a une relique de
# l'ancien format de la base
M1_F0 <- M1_F0 %>% 
  haven::zap_label() %>% 
  haven::zap_formats()

M1_F1 <- M1_F0 %>% 
  mutate(
    fac1 = case_when(
      id_sexe == 1 ~ "Homme",
      id_sexe == 2 ~ "Femme") %>% factor())

M1_F1 <- M1_F1 %>% 
  mutate(
    fac2 = case_when(
      id_sexe == 1 ~ 1,
      id_sexe == 2 ~ 2) %>% factor())

M1_F1 <- M1_F1 %>% 
  mutate(fac3 = factor(id_sexe))

M1_F1 <- M1_F1 %>% 
  mutate(
    fac4 = case_when(
      id_sexe == 1 ~ "Homme",
      id_sexe == 2 ~ "Femme") %>% factor(levels = c("Homme", "Femme")))

M1_F1 <- M1_F1 %>% 
  mutate(
    fac5 = case_when(
      id_sexe == 2 ~ "Femme",
      id_sexe == 1 ~ "Homme") %>% factor(labels = c("Femme", "Homme")))

# Maintenant, je veux comprendre la distinction entre labelled et factors
# > class(M1_F0$id_sexe)
# [1] "numeric"
# > typeof(M1_F0$id_sexe)
# [1] "double"

# Pour l'instant, id_sexe n'est qu'un vecteur numérique de type double
# > str(M1_F0$id_sexe)
# num [1:454] 2 1 1 2 1 2 2 1 2 1 ...

# Mais je veux le convertir en vecteur pour faciliter la représentation.
# Je ne veux pas devoir taper homme ou femme, j'aimerais conserver les valeurs
# numériques pour faciliter la manipulation.

# Fonction pour créer variable de lien pour les doublons
make_id_link <- function(df){
  df %>%
    separate(id_sep,
             into = c("rid", "id_link"),
             sep = "_",
             remove = FALSE,
             fill = "right") %>% 
    select(-rid) %>% 
    mutate(
      id_link = case_when(
        is.na(id_date_creation) ~ id_anonymat,
        is.na(id_link) ~ id_anonymat,
        TRUE ~ id_link
      )
    ) 
}

M1_F1 <- M1_F0 %>% 
  make_id_link() %>% 
  relocate(c("id_link", "id_sep"), .after = id_anonymat) %>% 
  mutate(across(all_of(starts_with("id_centre")), as.factor))

# Essayer de comprendre différence entre levels et labels d'un facteur
# Juste les étiquettes qui sont visibles
M1_F2 <- M1_F1 %>% 
  mutate(fac1 = case_when(
    id_sexe == 1 ~ 1,
    id_sexe == 2 ~ 2) %>% factor(., labels = c("Homme", "Femme")))
# > attributes(M1_F2$fac1)
# $levels
# [1] "Homme" "Femme"
# 
# $class
# [1] "factor"
# 
# > typeof(M1_F2$fac1)
# [1] "integer"

M1_F2 <- M1_F2 %>% 
  mutate(fac2 = case_when(
    id_sexe == 1 ~ "Homme",
    id_sexe == 2 ~ "Femme") %>% factor())

# > attributes(M1_F2$fac2)
# $levels
# [1] "Femme" "Homme"
# 
# $class
# [1] "factor"
# 
# > typeof(M1_F2$fac2)
# [1] "integer"



# Aussi juste les étiquettes qui sont visibles
M1_F3 <- M1_F1 %>% 
  mutate(fac1 = case_when(
    id_sexe == 1 ~ "Homme",
    id_sexe == 2 ~ "Femme") %>% factor())

M1_F4 <- M1_F1 %>% 
  mutate(fac1 = case_when(
    id_sexe == 1 ~ 1,
    id_sexe == 2 ~ 2) %>% factor(., levels = c("Homme", "Femme")))

M1_F5 <- M1_F1 %>% 
  mutate(fac1 = case_when(
    id_sexe == 2 ~ 2,
    id_sexe == 1 ~ 1) %>% factor(., labels = c("Femme", "Homme")))




