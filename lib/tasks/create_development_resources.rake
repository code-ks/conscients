# frozen_string_literal: true

Rails.logger = Logger.new(STDOUT)

task create_development_resources: :environment do
  desc 'Create minimal resources to allow tests in development'

  StockEntry.delete_all
  Product.destroy_all
  AdminUser.destroy_all
  Categorization.destroy_all
  ProductSku.destroy_all
  Variabilization.destroy_all

  product = Product.create!(
    name_fr: 'Top livre',
    name_en: 'Top book',
    description: "Un top livre qui vaut vraiment le coup et que tout\
    le monde devrait lire parce qu'il est vraiment bien",
    ht_price_cents: 1000,
    weight: 1000,
    ht_buying_price_cents: 900,
    seo_title: 'Super Top Livre',
    meta_description: "Un top livre qui vaut vraiment le coup et que tout\
    le monde devrait lire parce qu'il est vraiment bien",
    keywords: %w[top livre]
  )
  ProductSku.create(product: product)

  product = Product.create!(
    name_fr: 'Top livre 2',
    name_en: 'Top book 2',
    description: "Un deuxième top livre qui vaut vraiment le coup et que tout\
    le monde devrait lire parce qu'il est vraiment bien",
    ht_price_cents: 1000,
    weight: 1000,
    ht_buying_price_cents: 900,
    seo_title: 'Top Livre 2',
    meta_description: "Un deuxième top livre qui vaut vraiment le coup et que tout\
    le monde devrait lire parce qu'il est vraiment bien",
    keywords: %w[top livre]
  )
  ProductSku.create(product: product)

  product = Product.create!(
    name_fr: 'Top vêtement garçon',
    name_en: 'Great boy cloth',
    description: "Un top vetement garçon qui vaut vraiment le coup et que tout\
    le monde devrait porter parce qu'il est vraiment bien",
    ht_price_cents: 1200,
    weight: 500,
    ht_buying_price_cents: 1000,
    seo_title: 'Top vetement garçon',
    meta_description: "Un top vetement garçon qui vaut vraiment le coup et que tout\
    le monde devrait porter parce qu'il est vraiment bien",
    keywords: %w[top vetement garçon]
  )
  product_sku = ProductSku.create(product: product)
  product_sku.variants << Variant.find_by(value: '0 à 3 mois')
  product_sku = ProductSku.create(product: product)
  product_sku.variants << Variant.find_by(value: '3 à 6 mois')
  product_sku = ProductSku.create(product: product)
  product_sku.variants << Variant.find_by(value: '6 à 12 mois')

  product = Product.create!(
    name_fr: 'Top vêtement fille',
    name_en: 'Great girl cloth',
    description: "Un top vetement fille qui vaut vraiment le coup et que tout\
    le monde devrait porter parce qu'il est vraiment bien",
    ht_price_cents: 1200,
    weight: 500,
    ht_buying_price_cents: 1000,
    seo_title: 'Top vetement fille',
    meta_description: "Un top vetement fille qui vaut vraiment le coup et que tout\
    le monde devrait porter parce qu'il est vraiment bien",
    keywords: %w[top vetement fille]
  )
  product_sku = ProductSku.create(product: product)
  product_sku.variants << Variant.find_by(value: '0 à 3 mois')
  product_sku = ProductSku.create(product: product)
  product_sku.variants << Variant.find_by(value: '3 à 6 mois')
  product_sku = ProductSku.create(product: product)
  product_sku.variants << Variant.find_by(value: '6 à 12 mois')

  product = Product.create!(
    name_fr: 'Livre et arbre',
    name_en: 'Book and tree',
    description: "Un top bundle livre + arbre qui vaut vraiment le coup et que tout\
    le monde devrait acheter parce qu'il est vraiment bien",
    ht_price_cents: 1700,
    weight: 1000,
    product_type: 1,
    ht_buying_price_cents: 1300,
    seo_title: 'Top bundle livre + arbre',
    meta_description: "Un top bundle livre + arbrequi vaut vraiment le coup et que tout\
    le monde devrait acheter parce qu'il est vraiment bien",
    keywords: %w[top bundle livre arbre]
  )
  ProductSku.create(product: product)

  product = Product.create!(
    name_fr: 'Arbre',
    name_en: 'Top Tree',
    description: "Un arbre qui vaut vraiment le coup et que tout\
    le monde devrait acheter parce qu'il est vraiment bien",
    ht_price_cents: 500,
    product_type: 2,
    ht_buying_price_cents: 400,
    seo_title: 'Super Top arbre',
    meta_description: "Un arbre qui vaut vraiment le coup et que tout\
    le monde devrait acheter parce qu'il est vraiment bien",
    keywords: %w[top bundle livre arbre]
  )
  ProductSku.create(product: product)

  Product.all.each do |p|
    p.images.attach(io: File.open('lib/assets/tree.jpeg'),
                   filename: 'tree.jpeg', content_type: 'image/jpeg')
    p.images.attach(io: File.open('lib/assets/book.jpeg'),
                   filename: 'book.jpeg', content_type: 'image/jpeg')
    8.times do
      Categorization.find_or_create_by!(product: p, category: Category.all.sample)
    end
    p.save
  end

  ProductSku.all.each do |sku|
    2.times { StockEntry.create!(product_sku: sku, quantity: rand(1..10)) }
  end

  Rails.logger.info "#{Product.all.count} products created with SKU and co"

  if Rails.env.development?
    AdminUser.create!(email: 'admin@example.com', password: 'password',
                      password_confirmation: 'password')
  end
end
