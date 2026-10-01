mmp_mkdir() {
  read -r -p "Nom du dossier: " target
  mkdir "${target}"
}
