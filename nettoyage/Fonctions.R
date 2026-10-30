

# Fonction pour identifier les noms de variables qui sont trop longs
taille_vars <- function(df){
  
  # Extraire tous les noms des variables de la base de données
  long_vars <- colnames(df)
  
  for (i in long_vars) {
    
    # Si un nom est plus petit que 32 caractères, 
    if (stringr::str_length(i) < 32) {
      # Alors le retirer de la liste des noms
      long_vars <- long_vars[!long_vars == i]
    }
  }
  
  # Donc on ne garde que les noms de 32 caractères ou plus
  print(long_vars)
  
  
}

