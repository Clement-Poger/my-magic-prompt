mmp_open() {
  read -r -p "Nom du fichier: " target
  vim "${target}"
}
