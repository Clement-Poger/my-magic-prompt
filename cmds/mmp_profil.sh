mmp_profil() {
  local legacy_profile="$SCRIPT_DIR/.my_magic_mmp_profile"
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
