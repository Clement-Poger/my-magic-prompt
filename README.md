# My Magic Prompt
> **Author** : **Clément Poger**

**(UK)** <br>
*This project was created for educational purposes, with the goal of discovering Bash scripting.*
---
This project is a prompt that allows you to customize your terminal and add new features.
- Among the available features, you can:
> - Configure a profile <br>
> - Play Rock Paper Scissors (and more...) <br>
> - Retrieve information about your system <br>
> - Download files from the internet <br>
> - ...
To launch the project, copy `.env.example` to `.env`, set `PROMPT_USERNAME` and a strong `PROMPT_PASSWORD`, then run `./main.sh` from the project directory. The login compares the username exactly, including capitalization. Profile details and password are stored in `.env`; keep it private (it is ignored by Git).

---


**(FR)** <br>
*Ce projet a été crée dans un cadre éducatif ayant pour objectif la découverte du Bash Scripting.*
---
Ce projet est un prompt qui vous permet de personnaliser votre terminal et d'avoir de nouvelles fonctionnalités.
- Parmis les fonctionnalités disponibles, vous pouvez :
> - Configurer un profil <br>
> - Jouer au Rock Paper Scissors (et plus...) <br>
> - Récupérer des informations sur votre système <br>
> - Récupérer des fichiers sur internet <br>
> - ...
Pour lancer le projet, copiez `.env.example` vers `.env`, renseignez `PROMPT_USERNAME` et un `PROMPT_PASSWORD` robuste, puis exécutez `./main.sh` depuis la racine du projet. Le nom d'utilisateur est comparé exactement, majuscules comprises. Le profil et le mot de passe sont stockés dans `.env`; gardez ce fichier privé, Git l'ignore.