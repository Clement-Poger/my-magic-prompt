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
