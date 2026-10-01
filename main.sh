#!/bin/bash

source "./cmds/quit.sh"
source "./cmds/help.sh"
source "./cmds/file_commands.sh"
source "./cmds/navigation_commands.sh"
source "./cmds/network_commands.sh"
source "./cmds/profile_commands.sh"
source "./cmds/rps.sh"

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
    *) echo "Commande inconnue";;
  esac
}

main() {
  local lineCount=1
  local PROFIL_FILE="${HOME}/my-magic-prompt/.my_magic_prompt_profile"

  if [ -f "$PROFIL_FILE" ]; then
    . "$PROFIL_FILE"
  fi
  read -r -p "Nom: " login
  read -r -s -p "Code: " psswrd
  echo ""
  if [[ "$login" == "Xzen" && "$psswrd" == "$PROFIL_CODE" ]]; then
    while [ 1 ]; do
      local date
      date=$(date +%H:%M)
      echo -ne "${date} - [\033[31m${lineCount}\033[m] - \033[33mXzen\033[m ~ ☠️ ~ "
      read -r string

      cmd $string
      lineCount=$(($lineCount+1))
    done
  else
    echo "Code Faux! Vous ne pouvez pas continuer."
  fi
}

main