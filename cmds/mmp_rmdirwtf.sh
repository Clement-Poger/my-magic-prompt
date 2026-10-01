mmp_rmdirwtf() {
  read -r -p "Cette commande nécessite votre mot de passe.
 - Mot de passe: " psswrd
  if [[ "$psswrd" == "$PROMPT_PASSWORD" ]]; then
    while true; do
      read -r -p "Dossier à supprimer: " target
      cmd rmd "$target"
      read -r -p "Voulez-vous en supprimer un autre ? [Y-n] " repdel
      if [[ "$repdel" =~ ^[Yy]$ ]]; then
        continue
      else
        break
      fi
    done
  else
    echo "Code Faux! Vous ne pouvez pas continuer."
  fi
}
