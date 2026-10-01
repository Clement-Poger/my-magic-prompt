#!/bin/bash
source quit.sh

cmd() {
  local cmd=$1
  argv=$*

  case "${cmd}" in
    help ) echo "                < My Magic Prompt par Clement POGER > 
  Toutes les Commandes:
    - help:             Liste les commandes disponibles.
    - ls (-al):         Liste fichiers et dossiers, visibles comme cachés.
    - rm:               Supprime un fichier.
    - rmd/rmdir:        Supprime un dossier.
    - about:            Description de votre programme.
    - version/--v/vers: Affiche la version du prompt. 
    - age:              Demande votre âge : majeur ou mineur ?
    - quit/exit:        Quitte le prompt.
    - profil:           Prénom, nom, âge et email.
    - passw:            Change le mot de passe, avec confirmation.
    - cd:               Va dans un dossier créé ou revient au précédent.
    - pwd:              Affiche le répertoire courant.
    - hour:             Donne l'heure actuelle.
    - *:                Signale une commande inconnue.
    - httpget:          Télécharge le HTML d'une page ; demande le nom du fichier.
    - smtp:             Envoie un mail : adresse, sujet, corps.
    - open:             Ouvre un fichier dans VIM, même s'il n'existe pas.

    - cp:               Crée une copie d'un fichier ou d'un dossier.
    - ln:               Crée un lien.
    - echo:             Affiche des mots dans la sortie.
    - touch:            Crée un nouveau fichier.
    - rv:               Modifie le nom ou le chemin du fichier.
    - mkdir:            Crée un nouveau dossier.
    - cat:              Affiche le contenu du fichier.
    - chmod:            Modifie les permissions du fichier.
    - date:             Affiche la date et l'heure actuelles.
    - clear:            Efface tout.";;
    
    ls ) case "${argv}" in
        "ls -a" ) ls -a ;;
        "ls -l" ) ls -l ;;
        "ls -al" | "ls -la" ) ls -al ;;
        "ls" ) ls;;
        *) echo "Argument introuvable";;
    esac;;
    
    rm ) read -r -p "Fichier à supprimer: " target
    rm "${target}";;
    
    rmd | rmdir ) read -r -p "Dossier à supprimer: " target
    rm -rf "${target}";;
    
    about ) echo "                < My Magic Prompt par Clement POGER > 

    My Magic Prompt est un mini-shell personnalise.

    Fonctionnalites principales :
      - gestion rapide des dossiers et fichiers (ls, cd, touch, mkdir, rm)
      - affichage du chemin courant et de l'heure
      - interface minimaliste avec prompt colore

    Ce projet a ete realise dans un but d'apprentissage et d'experimentation
    autour du Bash, des scripts shell et de la creation d'un environnement de
    travail.";;
    
    version | --v | vers ) echo "MyMagicPrompt_-_Clement_POGER >> v0.01";;
    
    age ) read -r -p "Pouvez-vous indiquer votre age? " yold
    if [ -z "$yold" ]; then
            echo "Merci d'indiquer votre age.";
    elif [ "$yold" -ge 18 ]; then
              echo "J'en deduit que vous êtes majeur.";
    else
              echo "J'en deduit que vous êtes mineur.";
    fi;;
    
    quit | exit ) quit;;
    
    profil ) 
    PROFIL_FILE="${HOME}/my-magic-prompt/.my_magic_prompt_profile"

    if [ -f "$PROFIL_FILE" ]; then
      . "$PROFIL_FILE"
    fi

    echo "Bienvenue dans l'outil d'edition de votre profil"
    echo "    1) Modifier le prénom"
    echo "    2) Modifier le nom"
    echo "    3) Modifier l'age"
    echo "    4) Modifier l'email"
    echo "    5) Voir son profil"
    echo "    6) Quitter"

    while :; do
      read -r -p "Choix [1-6]: " profil_choice
      case "$profil_choice" in
        1|prenom|firstname)
          read -r -p "Nom [${PROFIL_PRENOM:-Inconnu}]: " new_prenom
          if [ -n "$new_prenom" ]; then
            PROFIL_PRENOM="$new_prenom"
          fi
          ;;
        2|nom|name)
          read -r -p "Nom [${PROFIL_NOM:-Inconnu}]: " new_nom
          if [ -n "$new_nom" ]; then
            PROFIL_NOM="$new_nom"
          fi
          ;;
        3|age|âge)
          read -r -p "Age [${PROFIL_AGE:-Inconnu}]: " new_age
          if [[ "$new_age" =~ ^[0-9]+$ ]]; then
            PROFIL_AGE="$new_age"
          else
            echo "Merci d'indiquer un age valide."
          fi
          ;;
        4|email|mail)
          read -r -p "Email [${PROFIL_EMAIL:-Inconnu}]: " new_email
          if [ -n "$new_email" ]; then
            PROFIL_EMAIL="$new_email"
          fi
          ;;
          
          
        5|voir|look)
          echo "Prénom: ${PROFIL_PRENOM}"
          echo "Nom: ${PROFIL_NOM}"
          echo "Age: ${PROFIL_AGE}"
          echo "Email: ${PROFIL_EMAIL}"
          echo "Code: Code masqué"
          ;;
        6|q|quit|exit)
          echo "Profil enregistre dans $PROFIL_FILE"
          break
          ;;
        *)
          echo "Choix invalide."
          ;;
      esac

    printf "%s\n" "PROFIL_PRENOM='${PROFIL_PRENOM:-}'" "PROFIL_NOM='${PROFIL_NOM:-}'" "PROFIL_AGE='${PROFIL_AGE:-}'" "PROFIL_EMAIL='${PROFIL_EMAIL:-}'" "PROFIL_CODE='${PROFIL_CODE:-}'" > "$PROFIL_FILE"

    done;;
    
    rmdirwtf )
    read -r -p "Cette commande nécessite votre mot de passe.
 - Mot de passe: " psswrd
    if [[ "$psswrd" == "$PROFIL_CODE" ]]; then
      while true; do
        read -r -p "Dossier à supprimer: " target
        cmd rmd "$target"
        read -r -p "Voulez-vous en supprimer un autre ? [Y-n] " repdel
        if [[ "$repdel" =~ ^[Yy]$ ]]; then
          continue
        else
          break
        fi
      done
    else
      echo "Code Faux! Vous ne pouvez pas continuer."
    fi;;

    passw ) 
    PROFIL_FILE="${HOME}/my-magic-prompt/.my_magic_prompt_profile"

    if [ -f "$PROFIL_FILE" ]; then
      . "$PROFIL_FILE"
    fi
    read -r -s -p "Ancien Code [Masqué]: " code
    if [[ "$code" == "$PROFIL_CODE" ]]; then
    read -r -s -p "Nouveau Code: " new_code
      read -r -s -p "Confirmer le Nouveau Code: " new_code2
      if [[ "$new_code" == "$new_code2" && -n "$new_code" ]]; then
        PROFIL_CODE="$new_code"
      else
        echo "Les codes ne correspondent pas ou sont vides."
        continue
      fi
      mkdir -p "$(dirname "$PROFIL_FILE")"
      printf "%s\n" "PROFIL_PRENOM='${PROFIL_PRENOM:-}'" "PROFIL_NOM='${PROFIL_NOM:-}'" "PROFIL_AGE='${PROFIL_AGE:-}'" "PROFIL_EMAIL='${PROFIL_EMAIL:-}'" "PROFIL_CODE='${PROFIL_CODE:-}'" > "$PROFIL_FILE"
    else
      echo "Code Faux! Vous ne pouvez pas continuer."
    fi;;

    cd )
      if [ "$#" -gt 1 ]; then
        builtin cd -- "$2"
      elif [ -n "${OLDPWD:-}" ]; then
        builtin cd -- -
      else
        builtin cd -- "$HOME"
      fi;;
    
    pwd ) realpath .;;
    
    hour ) date +"%H:%M";;
    
    smtp ) read -r -p "Veuillez Indiquer :
    - l'Addresse mail du receveur: " mail_ad
    read -r -p "    - le sujet: " mail_sujet
    read -r -p "    - le corps: " mail_corps
    printf '%s\n' "$mail_corps" | mail -s "$mail_sujet" "$mail_ad";;
    
    httpget )
        if [ "$#" -lt 2 ]; then
            echo "Usage: httpget <url>";
        else
            url="$2"
            case "${url}" in
                http://*|https://*|ftp://*) ;;
                *) url="https://${url}" ;;
            esac
            read -r -p "Nom du Fichier d'Output: " filename
            wget -O "${filename}" "${url}"
        fi;;
    
    echo ) read -r -p "Texte à Push: " target
    echo "${target}";;

    open ) read -r -p "Nom du fichier: " target
    vim "${target}";;
    
    touch ) read -r -p "Nom du fichier: " target
    touch "${target}";;
    
    mkdir ) read -r -p "Nom du dossier: " target
    mkdir "${target}";;
    
    cat ) read -r -p "Nom du fichier: " target
    cat "${target}";;
    
    clear ) clear;;   

    rps )
      read_rps_choice() {
        local player="$1"
        local choice

        while true; do
          show_header
          read -r -p " | $player! Sélectionnez votre action: " choice
          choice=${choice,,}

          case "$choice" in
            1|pi|pierre|rock) RPS_CHOICE="Pierre"; return 0 ;;
            2|papier|pa|paper) RPS_CHOICE="Papier"; return 0 ;;
            3|ciseaux|c|scissors|scissor) RPS_CHOICE="Ciseaux"; return 0 ;;
            4|super|superkitty|kitty) RPS_CHOICE="SuperKitty"; return 0 ;;
            *) echo "Choix invalide. Réessayez." ;;
          esac
        done
      }

      show_header() {
        clear
        echo ""
        echo "Player 1 ✿ $player1   $(score_display "$score1")     VS     $(score_display "$score2")   $player2 ✿ Player 2"
        echo ""
      }

      score_display() {
        local points=$1
        local display=""
        local i

        for ((i = 0; i < 3; i++)); do
          if ((i < points)); then
            display+="⬤"
          else
            display+="o"
          fi
          ((i < 2)) && display+=" "
        done

        printf '%s' "$display"
      }
      
      read -r -p "| Quel est votre nom, joueur 1? " player1
      echo ""
      read -r -p "| Quel est votre nom, joueur 2? " player2

      score1=0
      score2=0


      while true; do
      
        read_rps_choice "✿ $player1"
        rps_player1=$RPS_CHOICE
        echo ""
        read_rps_choice "✿ $player2"
        rps_player2=$RPS_CHOICE


        show_header
        echo "| ✿ $player1 : $rps_player1 VS $rps_player2 : $player2 ✿"
        if [[ "$rps_player1" == "$rps_player2" ]]; then
          echo "| Égalité !"
        elif [[
          ( "$rps_player1" == "pierre" && "$rps_player2" == "ciseaux" ) ||
          ( "$rps_player1" == "papier" && "$rps_player2" == "pierre" ) ||
          ( "$rps_player1" == "ciseaux" && "$rps_player2" == "papier" ) ||
          ( "$rps_player1" == "SuperKitty" && "$rps_player2" == "ciseaux" ) ||
          ( "$rps_player1" == "SuperKitty" && "$rps_player2" == "pierre" ) ||
          ( "$rps_player1" == "SuperKitty" && "$rps_player2" == "papier" )
        ]]; then
          ((score1 += 1))
          echo "| $player1 gagne la manche!"
        else
          ((score2 += 1))
          echo "| $player2 gagne la manche!"
        fi
        if [ "$score1" == "3" ]; then
          show_header
          echo "| $player1 gagne le match!"
          break
        elif [ "$score2" == "3" ]; then
          show_header
          echo "| $player2 gagne le match!"
          break
        fi

        read -r -p "
        
        Cliquez sur entrer pour passer à la manche suivante." a
      done;;
    
    *) echo "Commande inconnue";;
  esac
}

main() {
  lineCount=1
  PROFIL_FILE="${HOME}/my-magic-prompt/.my_magic_prompt_profile"

  if [ -f "$PROFIL_FILE" ]; then
    . "$PROFIL_FILE"
  fi
  read -r -p "Nom: " login
  read -r -s -p "Code: " psswrd
  echo ""
  if [[ "$login" == "Xzen" && "$psswrd" == "$PROFIL_CODE" ]]; then
    while [ 1 ]; do
      date=$(date +%H:%M)
      echo -ne "${date} - [\033[31m${lineCount}\033[m] - \033[33mXzen\033[m ~ ☠️ ~ "
      read -r string

      cmd $string
      lineCount=$(($lineCount+1))
    done
  else
    echo "Code Faux! Vous ne pouvez pas continuer.";
  fi;
}

main