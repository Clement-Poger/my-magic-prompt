mmp_rmd() {
  read -r -p "Dossier à supprimer: " target
  rm -rf "$target"
}
