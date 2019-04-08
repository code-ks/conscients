# Conscients

## Configurer l'application sur mon ordinateur

Ouvrir le terminal et lancer les commandes si dessous dans l'ordre:
- `git clone git@github.com:damienlethiec/conscients.git`
- `git pull origin master`
- `bundle install`
- `rails db:setup`
- `brew install overmind`
- `touch config/master.key` et copier dans le fichier tout juste créé la clé partagée par Damien
(ne jamais la dévoiler à personne)

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

### Pusher des changements locaux sur Heroku

 - Merger ma branche sur master
 - Se rendre sur le master en local
 - Pull le master avec `git pull origin master`
 - Pusher sur staging avec `git push staging master`
 - Faire les tests nécessaires sur l'app de staging
 - Quand l'app peut être passée en prod, se rendre sur le pipeline Heroku et cliquer sur `Promote to Production`

## Comprendre le fonctionnement des models

### Déterminer les catégories à afficher sur la home

 - Changer dans l'admin le `home_display` des catégories. Les 3 premières catégories lorsque triées par home display apparaitront dans le carousel du haut, la 4ème dans le carousel du bas.

### Précision model produit

 - La colonne `position` gère l'ordre des produits dans le shop (dans les catégories)
 - La colonne `position_home` gère l'ordre des produits dans les carousels de la home

### Créer une nouvelle catégorie

 - Faire bien attention à indiquer un slug en français et en anglais. Les validations devraient empêcher de ne pas le faire mais elles sont très compliquées à gérer pour les colonnes traduites donc ne sont pas 100% fiables
 - Pour trouver quoi indiquer dans ancestry, déterminer où placer la nouvelle catégorie dans l'arborescence, trouver les `id` des catégories parentes (toujours partir de l'id de `home`) puis les indiquer sous ce format `"<id_de_home>/<id_de_categorie_parente_si_existe>/..."`

### Créer un nouveau produit

  - Créer un produit en remplissant toutes les informations
  - Si ce produit a des variantes (des âges en particuliers), créer les variantes correspondantes si elles n'existent pas déjà
  - Pour chacune des variantes du produit, créer un UGS Produit qui lie le produit à cette variante. Si la produit n'a pas de variante, créer malgré tout un UGS Produit sans indiquer aucune variante
  - Pour chacune des catégories dont le produit fait partie, créer une catégorisation qui le lie à cette catégorie
  - Si le produit n'est pas un produit arbre, créer une Entrée de stock correspondant au stock de départ. Pour rajouter du stock ne jamais changer directement la quantité dans l'UGS Produit mais rajouter une nouvelle Entrée de stock (positive ou négative)
  - Si le produit est un arbre, créer une Plantation d'Arbre (ou s'assurer qu'il y en existe déjà avec suffisamment d'arbres restants). Pas besoin d'associer celle ci à l'UGS Produit, ce sera fait automatiquement

### Créer un coupon de réduction

  - Indiquer soit un montant, soit un pourcentage mais pas les 2
  - Si le coupon n'est valable que pour un produit ou pour un client, le lier à la resource en question

### Créer les resources initiales dans le code (seed ou rake task)

  - S'inspirer de `seeds.rb` pour les catégories (et notamment de la façon de gérer les parents)
  - Adapter `create_development_resources.rake` pour créer les autres types de resources

### README dev:

  - I use Rails 5.2 credentials to manage secrets
  - There are githooks (rubocop and brakeman) to pass before commiting
