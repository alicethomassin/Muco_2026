library(dplyr)
library(questionr)

M4_D1 <- readr::read_csv("../data_hors_git/process_data/thoa_M4_D1_tt.csv",
                         show_col_types = FALSE)



# Peter ------------------------------------------------------------------
# Il y aura deux étapes pour Peter. D'abord, la base nettoyé avec les NAs pour
# Stata. Ensuite, il faut faire un dictionnaire des variables où les NAs
# sont correctement identifiés. Pour y parvenir, il faut que les modalités 
# soient en facteurs, charactères.

# When you go from a character vector
char_named <- c("guava", "pineapple", "dragonfruit")
# Chaque character a une position dans le vecteur
# Donc pour obtenir le character de la position 1
char_named[1]
# > [1] "guava"

# Mais on ne peut pas obtenir la position d'un character
char_named["pineapple"]
#> [1] NA

# To named elements, you have a vector of doubles and not character
v_named <- c(guava = 2, pineapple = 4, dragonfruit = 1)


v_named[c("guava", "dragonfruit")]

# [] subsets multiple elements
v_named[2:3]
v_named[c("guava", "pineapple")]

# [[]] subset of a single element
# Dans le cas d'un named vector
v_named[["guava"]]
v_named[[1]]

char_named[["guava"]]

moons <-
  list(
    earth = 1737.1,
    mars = c(11.3, 6.2),
    neptune = 
      c(60.4, 81.4, 156, 174.8, 194, 34.8, 420, 2705.2, 340, 62, 44, 42, 40, 60)
  )

library(purrr)

map_int(moons, length)
