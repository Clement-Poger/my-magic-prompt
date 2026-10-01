prompt_rps() {
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
  done
}