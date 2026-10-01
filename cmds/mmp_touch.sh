mmp_touch() {
  read -r -p "Nom du fichier: " target
  touch "${target}"
}
