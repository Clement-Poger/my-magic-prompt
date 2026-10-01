mmp_smtp() {
  read -r -p "Veuillez Indiquer :
    - l'Addresse mail du receveur: " mail_ad
  read -r -p "    - le sujet: " mail_sujet
  read -r -p "    - le corps: " mail_corps
  printf '%s\n' "$mail_corps" | mail -s "$mail_sujet" "$mail_ad"
}
