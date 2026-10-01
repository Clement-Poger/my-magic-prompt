prompt_profil() {
  local PROFIL_FILE="${HOME}/my-magic-prompt/.my_magic_prompt_profile"

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
  done
}

prompt_rmdirwtf() {
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
  fi
}

prompt_passw() {
  local PROFIL_FILE="${HOME}/my-magic-prompt/.my_magic_prompt_profile"

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
  fi
}