prompt_profil() {
  local legacy_profile="$SCRIPT_DIR/.my_magic_prompt_profile"
  local profil_choice save_profile=0
  local new_prenom new_nom new_age new_email

  if [[ -f "$legacy_profile" && "${PROFILE_IMPORTED:-}" != "true" && -z "${PROFIL_PRENOM}${PROFIL_NOM}${PROFIL_AGE}${PROFIL_EMAIL}" ]]; then
    . "$legacy_profile"
    unset PROFIL_CODE
    if save_env_values \
      PROFIL_PRENOM "${PROFIL_PRENOM:-}" \
      PROFIL_NOM "${PROFIL_NOM:-}" \
      PROFIL_AGE "${PROFIL_AGE:-}" \
      PROFIL_EMAIL "${PROFIL_EMAIL:-}" \
      PROFILE_IMPORTED true; then
      PROFILE_IMPORTED=true
      mv -- "$legacy_profile" "$legacy_profile.migrated"
      echo "Ancien profil migré vers .env."
    else
      echo "Impossible de migrer l'ancien profil vers .env."
    fi
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
        ;;
      6|q|quit|exit)
        break
        ;;
      *)
        echo "Choix invalide."
        ;;
    esac

    case "$profil_choice" in
      1|prenom|firstname|2|nom|name|3|age|âge|4|email|mail) save_profile=1 ;;
      *) save_profile=0 ;;
    esac
    if (( save_profile )); then
      if save_env_values \
        PROFIL_PRENOM "${PROFIL_PRENOM:-}" \
        PROFIL_NOM "${PROFIL_NOM:-}" \
        PROFIL_AGE "${PROFIL_AGE:-}" \
        PROFIL_EMAIL "${PROFIL_EMAIL:-}"; then
        echo "Profil enregistré dans .env."
      else
        echo "Impossible d'enregistrer le profil dans .env."
      fi
    fi
  done
}

save_env_values() {
  local temp_file line key
  local -A values=() found=()

  while (( $# >= 2 )); do
    key=$1
    case "$key" in
      PROMPT_USERNAME|PROMPT_PASSWORD|PROFIL_PRENOM|PROFIL_NOM|PROFIL_AGE|PROFIL_EMAIL|PROFILE_IMPORTED) ;;
      *) return 1 ;;
    esac
    values["$key"]=$2
    shift 2
  done

  temp_file=$(mktemp "${ENV_FILE}.XXXXXX") || return 1
  {
    while IFS= read -r line || [[ -n "$line" ]]; do
      if [[ "$line" =~ ^([A-Za-z_][A-Za-z0-9_]*)= ]]; then
        key=${BASH_REMATCH[1]}
        if [[ ${values[$key]+present} ]]; then
          printf '%s=%q\n' "$key" "${values[$key]}"
          found["$key"]=1
        else
          printf '%s\n' "$line"
        fi
      else
        printf '%s\n' "$line"
      fi
    done < "$ENV_FILE"
    for key in "${!values[@]}"; do
      if [[ ! ${found[$key]+present} ]]; then
        printf '%s=%q\n' "$key" "${values[$key]}"
      fi
    done
  } > "$temp_file" || {
    rm -f -- "$temp_file"
    return 1
  }

  if ! chmod 600 "$temp_file" || ! mv -- "$temp_file" "$ENV_FILE"; then
    rm -f -- "$temp_file"
    return 1
  fi
  for key in "${!values[@]}"; do
    printf -v "$key" '%s' "${values[$key]}"
  done
}

prompt_rmdirwtf() {
  read -r -p "Cette commande nécessite votre mot de passe.
 - Mot de passe: " psswrd
  if [[ "$psswrd" == "$PROMPT_PASSWORD" ]]; then
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
  local code new_code new_code2
  read -r -s -p "Ancien Code [Masqué]: " code
  if [[ "$code" != "$PROMPT_PASSWORD" ]]; then
    echo "Code Faux! Vous ne pouvez pas continuer."
    return 1
  fi

  read -r -s -p "Nouveau Code: " new_code
  read -r -s -p "Confirmer le Nouveau Code: " new_code2
  echo ""
  if [[ "$new_code" != "$new_code2" || -z "$new_code" ]]; then
    echo "Les codes ne correspondent pas ou sont vides."
    return 1
  fi

  if ! save_prompt_password "$new_code"; then
    echo "Impossible d'enregistrer le nouveau code dans .env."
    return 1
  fi
  echo "Code mis à jour."
}

save_prompt_password() {
  save_env_values PROMPT_PASSWORD "$1"
}