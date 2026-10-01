mmp_rm() {
  read -r -p "Fichier à supprimer: " target
  rm "$target"
}
