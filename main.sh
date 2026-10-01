#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"

if [[ ! -r "$ENV_FILE" ]]; then
  echo "Configuration absente: créez $ENV_FILE à partir de .env.example." >&2
  exit 1
fi

if ! source "$ENV_FILE"; then
  echo "Impossible de charger $ENV_FILE." >&2
  exit 1
fi

PROMPT_USERNAME=${PROMPT_USERNAME%$'\r'}
PROMPT_PASSWORD=${PROMPT_PASSWORD%$'\r'}

if [[ -z "${PROMPT_USERNAME:-}" || -z "${PROMPT_PASSWORD:-}" ]]; then
  echo "Configurez PROMPT_USERNAME et PROMPT_PASSWORD dans .env." >&2
  exit 1
fi

: "${PROFIL_PRENOM:=}"
: "${PROFIL_NOM:=}"
: "${PROFIL_AGE:=}"
: "${PROFIL_EMAIL:=}"

for _script in "$SCRIPT_DIR"/commands/*.sh "$SCRIPT_DIR"/cmds/*.sh; do
  if [[ -f "$_script" ]]; then
    source "$_script"
  fi
done

cmd() {
  local command=${1:-}

  case "$command" in
    help ) mmp_help;;
    ls ) mmp_ls "$@";;
    rm ) mmp_rm;;
    rmd | rmdir ) mmp_rmd;;
    about ) mmp_about;;
    version | --v | vers ) mmp_version;;
    age ) mmp_age;;
    quit | exit ) quit;;
    profil ) mmp_profil;;
    rmdirwtf ) mmp_rmdirwtf;;
    passw ) mmp_passw;;
    cd ) mmp_cd "$@";;
    pwd ) mmp_pwd;;
    hour ) mmp_hour;;
    smtp ) mmp_smtp;;
    httpget ) mmp_httpget "$@";;
    echo ) mmp_echo;;
    open ) mmp_open;;
    touch ) mmp_touch;;
    mkdir ) mmp_mkdir;;
    cat ) mmp_cat;;
    clear ) mmp_clear;;
    rps ) mmp_rps;;
    joke ) mmp_joke;;
    calc ) mmp_calc;;
    *) echo "Commande inconnue";;
  esac
}

main() {
  local lineCount=1
  local login psswrd
  read -r -p "Nom: " login
  login=${login%$'\r'}
  login=${login:-$PROMPT_USERNAME}
  read -r -s -p "Code: " psswrd
  psswrd=${psswrd%$'\r'}
  echo ""
  if [[ "$login" != "$PROMPT_USERNAME" ]]; then
    echo "Nom incorrect. Vérifiez PROMPT_USERNAME dans .env."
  elif [[ "$psswrd" != "$PROMPT_PASSWORD" ]]; then
    echo "Code incorrect."
  else
    while [ 1 ]; do
      local date
      date=$(date +%H:%M)
      echo -ne "${date} - [\033[31m${lineCount}\033[m] - \033[33m${PROMPT_USERNAME}\033[m ~ ☠️ ~ "
      read -r string

      cmd $string
      lineCount=$(($lineCount+1))
    done
  fi
}

main