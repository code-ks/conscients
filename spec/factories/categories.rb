# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name_fr { 'Home' }
    slug_fr { 'Home' }
    name_en { 'Home' }
    slug_en { 'Home' }
  end
end

# default:
#   name: 'Home'
#   slug: 'home'
# name_fr: 'Home'
# slug_fr: 'home'
# name_en: 'Home'
# slug_en: 'home'
# node:
#   name_fr: 'Home'
#   slug_fr: 'home'
#   name_en: 'Home'
#   slug_en: 'home'

# coups-de-coeur:
#   name_fr: 'Coups de Coeur'
#   slug_fr: 'coups-de-coeur'
#   name_en: 'Favorites'
#   slug_en: 'favorites'
#   parent: node

# bebes:
#   name_fr: 'Bébés'
#   slug_fr: 'bebes'
#   name_en: 'Babies'
#   slug_en: 'babies'
#   parent: node
#   home_display: 4

# bebe-vetements-bio-garçon:
#   name_fr: 'Vêtements bio garçon'
#   slug_fr: 'bebe-vetements-bio-garçon'
#   name_en: 'Cloths bio boy'
#   slug_en: 'baby-cloths-bio-boy'
#   parent: bebes

# bebe-vetements-bio-fille:
#   name_fr: 'Vêtements bio fille'
#   slug_fr: 'bebe-vetements-bio-fille'
#   name_en: 'Cloths bio girl'
#   slug_en: 'baby-cloths-bio-girl'
#   parent: bebes

# bebe-livre:
#   name_fr: 'Livre'
#   slug_fr: 'bebe-livre'
#   name_en: 'Book'
#   slug_en: 'baby-book'
#   parent: bebes

# bebe-autres:
#   name_fr: 'Autres produits'
#   slug_fr: 'bebe-autres'
#   name_en: 'Other products'
#   slug_en: 'baby-others'
#   parent: bebes

# bebe-offrir-un-arbre:
#   name_fr: 'Offrir un arbre'
#   slug_fr: 'bebe-offrir-un-arbre'
#   name_en: 'Give a tree'
#   slug_en: 'baby-give-a-tree'
#   parent: bebes

# enfants:
#   name_fr: 'Enfants'
#   slug_fr: 'enfants'
#   name_en: 'Children'
#   slug_en: 'children'
#   parent: node

# enfants-vetements-bio-garçon:
#   name_fr: 'Vêtements bio garçon'
#   slug_fr: 'enfants-vetements-bio-garçon'
#   name_en: 'Cloths bio boy'
#   slug_en: 'children-cloths-bio-boy'
#   parent: enfants

# enfants-vetements-bio-fille:
#   name_fr: 'Vêtements bio fille'
#   slug_fr: 'enfants-vetements-bio-fille'
#   name_en: 'Cloths bio girl'
#   slug_en: 'children-cloths-bio-girl'
#   parent: enfants

# enfants-livre:
#   name_fr: 'Livre'
#   slug_fr: 'enfants-livre'
#   name_en: 'Book'
#   slug_en: 'children-book'
#   parent: enfants

# enfants-autres:
#   name_fr: 'Autres produits'
#   slug_fr: 'enfants-autres'
#   name_en: 'Other products'
#   slug_en: 'children-others'
#   parent: enfants

# enfants-offrir-un-arbre:
#   name_fr: 'Offrir un arbre'
#   slug_fr: 'enfants-offrir-un-arbre'
#   name_en: 'Give a tree'
#   slug_en: 'children-give-a-tree'
#   parent: enfants

# cadeaux:
#   name_fr: 'Cadeaux'
#   slug_fr: 'cadeaux'
#   name_en: 'Gifts'
#   slug_en: 'gifts'
#   parent: node

# offrir-un-arbre-cadeau:
#   name_fr: 'Offrir un arbre'
#   slug_fr: 'offrir-un-arbre-cadeau'
#   name_en: 'Give a tree'
#   slug_en: 'offrir-un-arbre-cadeau'
#   parent: cadeaux
#   home_display: 3)

# cadeaux-cadeaux-de-naissance:
#   name_fr: 'Cadeaux de naissance'
#   slug_fr: 'cadeaux-cadeaux-de-naissance'
#   name_en: 'Birth gifts'
#   slug_en: 'gifts-birth-gifts'
#   parent: cadeaux
#   home_display: 1)

# cadeaux-grands-et-les-petits:
#   name_fr: 'Pour les grands et les petits'
#   slug_fr: 'cadeaux-grands-et-les-petits'
#   name_en: 'For bigs and smalls'
#   slug_en: 'gifts-for-big-and-smalls'
#   parent: cadeaux
#   home_display: 2)

# cadeaux-pour-tous-de-naissance:
#   name_fr: 'Cadeaux de naissance'
#   slug_fr: 'cadeaux-pour-tous-de-naissance'
#   name_en: 'Birth gifts'
#   slug_en: 'gifts-for-everybody-birth-gifts'
#   parent: cadeaux-grands-et-les-petits

# cadeaux-pour-tous-d-anniversaire:
#   name_fr: "Cadeaux d'anniversaire'"
#   slug_fr: 'cadeaux-pour-tous-d-anniversaire'
#   name_en: 'Birthday gifts'
#   slug_en: 'gifts-for-everybody-birthday-gifts'
#   parent: cadeaux-grands-et-les-petits

# cadeaux-pour-tous-cadeaux-de-mariage:
#   name_fr: 'Cadeaux de mariage'
#   slug_fr: 'cadeaux-pour-tous-cadeaux-de-mariage'
#   name_en: 'Wedding gifts'
#   slug_en: 'gifts-for-everybody-wedding-gifts'
#   parent: cadeaux-grands-et-les-petits

# cadeaux-pour-tous-cadeaux-de-noel:
#   name_fr: 'Cadeaux de Noël'
#   slug_fr: 'cadeaux-pour-tous-cadeaux-de-noel'
#   name_en: 'Christmas gifts'
#   slug_en: 'gifts-for-everybody-christmas-gifts'
#   parent: cadeaux-grands-et-les-petits
