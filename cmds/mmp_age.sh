mmp_age() {
  read -r -p "Pouvez-vous indiquer votre age? " yold
  if [ -z "$yold" ]; then
    echo "Merci d'indiquer votre age."
  elif [ "$yold" -ge 18 ]; then
    echo "J'en deduit que vous êtes majeur."
  else
    echo "J'en deduit que vous êtes mineur."
  fi
}
