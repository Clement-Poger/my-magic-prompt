mmp_httpget() {
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
