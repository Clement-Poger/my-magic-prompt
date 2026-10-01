mmp_joke() {
  local blagues index
  echo "Voici une blague pour vous :"
  blagues=(
    "Pourquoi les plongeurs plongent-ils toujours en arrière et jamais en avant ? Parce que sinon ils tombent dans le bateau."
    "Quel est le comble pour un ordinateur ? Avoir un bug dans sa vie personnelle."
    "Pourquoi les fantômes sont-ils de mauvais cuisiniers ? Parce qu’ils ont peur des spectres !"
    "Qu’est-ce qu’un chat qui a pris des cours de piano ? Un chat-tariste."
    "Pourquoi le soleil ne va-t-il jamais au tribunal ? Parce qu’il a toujours un bon alibi."
    "Pourquoi les canards vont-ils toujours au travail ? Pour faire des heures supplémentaires."
    "Qu’est-ce qu’un crocodile qui fait du vélo ? Un vélo-croc."
    "Pourquoi les escargots sont-ils si lents ? Parce qu’ils prennent le temps de profiter de la vie."
    "Quel animal est le plus heureux en informatique ? Le lapin de Pâches, parce qu’il a beaucoup de code source."
    "Pourquoi les arbres adorent les maths ? Parce qu’ils aiment les racines carrées."
  )

  index=$(( RANDOM % ${#blagues[@]} ))
  echo "${blagues[$index]}"
}
