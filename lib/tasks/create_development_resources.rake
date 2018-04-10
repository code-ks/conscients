# frozen_string_literal: true

Rails.logger = Logger.new(STDOUT)

task create_development_resources: :environment do
  desc 'Create minimal resources to allow tests in development'

  Product.destroy_all

  Product.create!(
    name: 'Top livre',
    description: "Un top livre qui vaut vraiment le coup et que tout\
    le monde devrait lire parce qu'il est vraiment bien",
    ht_price_cents: 1000,
    weight: 1000,
    display_order: 1,
    ht_buying_price_cents: 900,
    seo_title: 'Super Top Livre',
    meta_description: "Un top livre qui vaut vraiment le coup et que tout\
    le monde devrait lire parce qu'il est vraiment bien",
    keywords: %w[top livre],
    url: 'top-livre'
  )
  Product.create!(
    name: 'Top livre 2',
    description: "Un deuxième top livre qui vaut vraiment le coup et que tout\
    le monde devrait lire parce qu'il est vraiment bien",
    ht_price_cents: 1000,
    weight: 1000,
    display_order: 1,
    ht_buying_price_cents: 900,
    seo_title: 'Top Livre 2',
    meta_description: "Un deuxième top livre qui vaut vraiment le coup et que tout\
    le monde devrait lire parce qu'il est vraiment bien",
    keywords: %w[top livre],
    url: 'top-livre-2'
  )
  Product.create!(
    name: 'Top vêtement garçon',
    description: "Un top vetement garçon qui vaut vraiment le coup et que tout\
    le monde devrait porter parce qu'il est vraiment bien",
    ht_price_cents: 1200,
    weight: 500,
    display_order: 1,
    ht_buying_price_cents: 1000,
    seo_title: 'Top vetement garçon',
    meta_description: "Un top vetement garçon qui vaut vraiment le coup et que tout\
    le monde devrait porter parce qu'il est vraiment bien",
    keywords: %w[top vetement garçon],
    url: 'top-vetement-garçon'
  )
  Product.create!(
    name: 'Top vêtement fille',
    description: "Un top vetement fille qui vaut vraiment le coup et que tout\
    le monde devrait porter parce qu'il est vraiment bien",
    ht_price_cents: 1200,
    weight: 500,
    display_order: 1,
    ht_buying_price_cents: 1000,
    seo_title: 'Top vetement fille',
    meta_description: "Un top vetement fille qui vaut vraiment le coup et que tout\
    le monde devrait porter parce qu'il est vraiment bien",
    keywords: %w[top vetement fille],
    url: 'top-vetement-fille'
  )
  Product.create!(
    name: 'Livre et arbre',
    description: "Un top bundle livre + arbre qui vaut vraiment le coup et que tout\
    le monde devrait acheter parce qu'il est vraiment bien",
    ht_price_cents: 1700,
    weight: 1000,
    display_order: 1,
    product_type: 1,
    ht_buying_price_cents: 1300,
    seo_title: 'Top bundle livre + arbre',
    meta_description: "Un top bundle livre + arbrequi vaut vraiment le coup et que tout\
    le monde devrait acheter parce qu'il est vraiment bien",
    keywords: %w[top bundle livre arbre],
    url: 'top-livre-arbre'
  )
  Product.create!(
    name: 'Arbre',
    description: "Un arbre qui vaut vraiment le coup et que tout\
    le monde devrait acheter parce qu'il est vraiment bien",
    ht_price_cents: 500,
    display_order: 1,
    product_type: 2,
    ht_buying_price_cents: 400,
    seo_title: 'Super Top arbre',
    meta_description: "Un arbre qui vaut vraiment le coup et que tout\
    le monde devrait acheter parce qu'il est vraiment bien",
    keywords: %w[top bundle livre arbre],
    url: 'top-arbre'
  )
  Rails.logger.info "#{Product.all.count} products created"
end
