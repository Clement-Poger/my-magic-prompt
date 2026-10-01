prompt_smtp() {
  read -r -p "Veuillez Indiquer :
    - l'Addresse mail du receveur: " mail_ad
  read -r -p "    - le sujet: " mail_sujet
  read -r -p "    - le corps: " mail_corps
  printf '%s\n' "$mail_corps" | mail -s "$mail_sujet" "$mail_ad"
}

prompt_httpget() {
  if [ "$#" -lt 2 ]; then
    echo "Usage: httpget <url>"
  else
    local url="$2"
    case "$url" in
      http://*|https://*|ftp://*) ;;
      *) url="https://${url}" ;;
    esac
    read -r -p "Nom du Fichier d'Output: " filename
    wget -O "${filename}" "$url"
  fi
}