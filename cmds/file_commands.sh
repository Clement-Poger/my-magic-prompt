prompt_ls() {
  local argv=$*
  case "$argv" in
    "ls -a" ) ls -a ;;
    "ls -l" ) ls -l ;;
    "ls -al" | "ls -la" ) ls -al ;;
    "ls" ) ls ;;
    *) echo "Argument introuvable" ;;
  esac
}

prompt_rm() {
  read -r -p "Fichier à supprimer: " target
  rm "$target"
}

prompt_rmd() {
  read -r -p "Dossier à supprimer: " target
  rm -rf "$target"
}

prompt_echo() {
  read -r -p "Texte à Push: " target
  echo "${target}"
}

prompt_open() {
  read -r -p "Nom du fichier: " target
  vim "${target}"
}

prompt_touch() {
  read -r -p "Nom du fichier: " target
  touch "${target}"
}

prompt_mkdir() {
  read -r -p "Nom du dossier: " target
  mkdir "${target}"
}

prompt_cat() {
  read -r -p "Nom du fichier: " target
  cat "${target}"
}

prompt_clear() {
  clear
}