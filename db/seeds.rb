# frozen_string_literal: true

Category.destroy_all

node = Category.create!(name_fr: 'Home', slug_fr: 'home', name_en: 'Home', slug_en: 'home')

Category.create!(name_fr: 'Coups de Coeur', slug_fr: 'coups-de-coeur',
                 name_en: 'Favorites', slug_en: 'favorites', parent: node)

first_child = Category.create!(name_fr: 'Bébés', slug_fr: 'bebes',
                               name_en: 'Babies', slug_en: 'babies', parent: node)
Category.create!(name_fr: 'Vêtements bio garçon', slug_fr: 'bebe-vetements-bio-garçon',
                 name_en: 'Cloths bio boy', slug_en: 'baby-cloths-bio-boy', parent: first_child)
Category.create!(name_fr: 'Vêtements bio fille', slug_fr: 'bebe-vetements-bio-fille',
                 name_en: 'Cloths bio girl', slug_en: 'baby-cloths-bio-girl', parent: first_child)
Category.create!(name_fr: 'Livre', slug_fr: 'bebe-livre',
                 name_en: 'Book', slug_en: 'baby-book', parent: first_child)
Category.create!(name_fr: 'Autres produits', slug_fr: 'bebe-autres',
                 name_en: 'Other products', slug_en: 'baby-others', parent: first_child)
Category.create!(name_fr: 'Offrir un arbre', slug_fr: 'bebe-give-a-tree',
                 name_en: 'Give a tree', slug_en: 'baby-give-a-tree', parent: first_child)

first_child = Category.create!(name_fr: 'Enfants', slug_fr: 'enfants',
                               name_en: 'Children', slug_en: 'children', parent: node)
Category.create!(name_fr: 'Vêtements bio garçon', slug_fr: 'enfants-vetements-bio-garçon',
                 name_en: 'Cloths bio boy', slug_en: 'children-cloths-bio-boy', parent: first_child)
Category.create!(name_fr: 'Vêtements bio fille', slug_fr: 'enfants-vetements-bio-fille',
                 name_en: 'Cloths bio girl', slug_en: 'children-cloths-bio-girl',
                 parent: first_child)
Category.create!(name_fr: 'Livre', slug_fr: 'enfants-livre',
                 name_en: 'Book', slug_en: 'children-book', parent: first_child)
Category.create!(name_fr: 'Autres produits', slug_fr: 'enfants-autres',
                 name_en: 'Other products', slug_en: 'children-others', parent: first_child)
Category.create!(name_fr: 'Offrir un arbre', slug_fr: 'enfants-give-a-tree',
                 name_en: 'Give a tree', slug_en: 'children-give-a-tree', parent: first_child)

first_child = Category.create!(name_fr: 'Cadeaux', slug_fr: 'cadeaux',
                              name_en: 'Gifts', slug_en: 'gifts', parent: node)
Category.create!(name_fr: 'Offrir un arbre', slug_fr: 'gifts-give-a-tree',
                 name_en: 'Give a tree', slug_en: 'gifts-give-a-tree', parent: first_child)
Category.create!(name_fr: 'Cadeaux de naissance', slug_fr: 'cadeaux-cadeaux-de-naissance',
                 name_en: 'Birth gifts', slug_en: 'gifts-birth-gifts', parent: first_child)
second_child = Category.create!(name_fr: 'Pour les grands et les petits',
                                slug_fr: 'cadeaux-grands-et-les-petits',
                                name_en: 'For bigs and smalls',
                                slug_en: 'gifts-for-big-and-smalls', parent: first_child)
Category.create!(name_fr: 'Cadeaux de naissance',
                slug_fr: 'cadeaux-pour-tous-de-naissance', name_en: 'Birth gifts',
                slug_en: 'gifts-for-everybody-birth-gifts', parent: second_child)
Category.create!(name_fr: "Cadeaux d'anniversaire'",
                 slug_fr: 'cadeaux-pour-tous-d-anniversaire',
                 name_en: 'Birthday gifts', slug_en: 'gifts-for-everybody-birthday-gifts',
                 parent: second_child)
Category.create!(name_fr: 'Cadeaux de mariage', slug_fr: 'cadeaux-pour-tous-cadeaux-de-mariage',
                name_en: 'Wedding gifts', slug_en: 'gifts-for-everybody-wedding-gifts',
                parent: second_child)
Category.create!(name_fr: 'Cadeaux de Noël', slug_fr: 'cadeaux-pour-tous-cadeaux-de-noel',
                name_en: 'Christmas gifts', slug_en: 'gifts-for-everybody-christmas-gifts',
                parent: second_child)

Rails.logger.info "#{Category.all.count} categories created"
