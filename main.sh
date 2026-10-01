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

source "$SCRIPT_DIR/commands/joke.sh"
source "$SCRIPT_DIR/cmds/quit.sh"
source "$SCRIPT_DIR/cmds/help.sh"
source "$SCRIPT_DIR/cmds/file_commands.sh"
source "$SCRIPT_DIR/cmds/navigation_commands.sh"
source "$SCRIPT_DIR/cmds/network_commands.sh"
source "$SCRIPT_DIR/cmds/profile_commands.sh"
source "$SCRIPT_DIR/cmds/rps.sh"

cmd() {
  local command=${1:-}

  case "$command" in
    help ) prompt_help;;
    ls ) prompt_ls "$@";;
    rm ) prompt_rm;;
    rmd | rmdir ) prompt_rmd;;
    about ) prompt_about;;
    version | --v | vers ) prompt_version;;
    age ) prompt_age;;
    quit | exit ) quit;;
    profil ) prompt_profil;;
    rmdirwtf ) prompt_rmdirwtf;;
    passw ) prompt_passw;;
    cd ) prompt_cd "$@";;
    pwd ) prompt_pwd;;
    hour ) prompt_hour;;
    smtp ) prompt_smtp;;
    httpget ) prompt_httpget "$@";;
    echo ) prompt_echo;;
    open ) prompt_open;;
    touch ) prompt_touch;;
    mkdir ) prompt_mkdir;;
    cat ) prompt_cat;;
    clear ) prompt_clear;;
    rps ) prompt_rps;;
    joke ) prompt_joke;;
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