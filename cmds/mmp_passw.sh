mmp_passw() {
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

  if ! save_mmp_password "$new_code"; then
    echo "Impossible d'enregistrer le nouveau code dans .env."
    return 1
  fi
  echo "Code mis à jour."
}
