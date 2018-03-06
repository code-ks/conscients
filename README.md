# Conscients

## Configurer l'application sur mon ordinateur

Ouvrir le terminal et lancer les commandes si dessous dans l'ordre:
- `git clone git@github.com:damienlethiec/conscients.git`
- `git co -b develop`
- `git pull origin develop`
- `bundle install`
- `rails db:setup`
- `brew install overmind`

## Travailler sur l'application

### Travailler sur une feature

- Commencer ma feature: `git co -b feature/<nom-de-ma-feature>`
- Lancer l'application (attention, avec webpack ce n'est plus `rails s`): `overmind start -f Procfile.dev`
- Finir ma feature: `git add .` puis `git commit -m <message>` puis `git push origin 
feature/<nom-de-ma-feature>`. Puis faire une pull request sur Github et demander une code review 
sur Slack

### Créer des pages de contenu avec High Voltage

Pour aller plus loin, se référer à la [documentation](https://github.com/thoughtbot/high_voltage)
 High Voltage.

- Commencer une nouvelle page: Créer un fichier `<nom-de-ma-page>.html.erb` dans le dossier 
`app/views/pages`. Ma page est tout de suite disponible sur `localhost:3000/<nom-de-ma-page>` 
(version française) ou sur `localhost:3000/en/<nom-de-ma-page>` (version anglaise).
- Gérer I18n: Dans mes pages, intégrer tout le contenu avec I18n via le format suivant: `t 
'pages/<nom-de-ma-page>/<identifiant-du-contenu>`. Créer ensuite le contenu dans les fichiers 
`fr` et `en` situés dans `config/locales/views` et ajouter les balises nécessaires et suivant les
 exemples existants.
 - Gérer le SEO d'une page: processus à compléter (si tu veux le créer, avec plaisir)
 - Travailler le front de ma page: faire du HTML/CSS classique, bootstrap est déjà installé
