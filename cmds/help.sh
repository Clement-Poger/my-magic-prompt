prompt_help() {
  echo "                < My Magic Prompt par Clement POGER >
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
    - clear:            Efface tout."
}

prompt_about() {
  echo "                < My Magic Prompt par Clement POGER >

    My Magic Prompt est un mini-shell personnalisé, conçu pour simplifier
    l'utilisation des commandes courantes dans un environnement interactif.

    Fonctionnalités principales :
      - gestion rapide des fichiers et des dossiers (ls, cd, touch, mkdir, rm)
      - affichage du répertoire courant, de la date et de l'heure
      - interface minimaliste avec un prompt coloré
      - accès aux commandes essentielles depuis un espace unique

    Ce projet a été réalisé à des fins d'apprentissage et d'expérimentation
    autour de Bash, des scripts shell et de la création d'un environnement de
    travail simple et personnalisé."
}

prompt_version() {
  echo "MyMagicPrompt_-_Clement_POGER >> v0.01"
}

prompt_age() {
  read -r -p "Pouvez-vous indiquer votre age? " yold
  if [ -z "$yold" ]; then
    echo "Merci d'indiquer votre age."
  elif [ "$yold" -ge 18 ]; then
    echo "J'en deduit que vous êtes majeur."
  else
    echo "J'en deduit que vous êtes mineur."
  fi
}