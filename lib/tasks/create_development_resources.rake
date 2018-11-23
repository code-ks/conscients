# frozen_string_literal: true

Rails.logger = Logger.new(STDOUT)

task create_development_resources: :environment do
  desc 'Create minimal resources to allow tests in development'

  StockEntry.delete_all
  Product.destroy_all
  AdminUser.destroy_all
  Categorization.destroy_all
  ProductSku.destroy_all
  Client.destroy_all
  Address.destroy_all
  Coupon.destroy_all
  Order.destroy_all
  LineItem.destroy_all
  TreePlantation.destroy_all

  product = Product.create!(
    name_fr: 'Top livre',
    name_en: 'Top book',
    description_short: "Un top livre qui vaut vraiment le coup et que tout\
    le monde devrait lire parce qu'il est vraiment bien",
    ht_price_cents: 1000,
    weight: 1000,
    ht_buying_price_cents: 900,
    seo_title: 'Super Top Livre',
    meta_description: "Un top livre qui vaut vraiment le coup et que tout\
    le monde devrait lire parce qu'il est vraiment bien",
    keywords: %w[top livre]
  )
  ProductSku.create!(product: product)

  product = Product.create!(
    name_fr: 'Top livre 2',
    name_en: 'Top book 2',
    description_short: "Un deuxième top livre qui vaut vraiment le coup et que tout\
    le monde devrait lire parce qu'il est vraiment bien",
    ht_price_cents: 1000,
    weight: 1000,
    ht_buying_price_cents: 900,
    seo_title: 'Top Livre 2',
    meta_description: "Un deuxième top livre qui vaut vraiment le coup et que tout\
    le monde devrait lire parce qu'il est vraiment bien",
    keywords: %w[top livre]
  )
  ProductSku.create!(product: product)

  product = Product.create!(
    name_fr: 'Top vêtement garçon',
    name_en: 'Great boy cloth',
    description_short: "Un top vetement garçon qui vaut vraiment le coup et que tout\
    le monde devrait porter parce qu'il est vraiment bien",
    ht_price_cents: 1200,
    weight: 500,
    ht_buying_price_cents: 1000,
    seo_title: 'Top vetement garçon',
    meta_description: "Un top vetement garçon qui vaut vraiment le coup et que tout\
    le monde devrait porter parce qu'il est vraiment bien",
    keywords: %w[top vetement garçon]
  )
  product_sku = ProductSku.create!(product: product)
  product_sku.update(variant: Variant.find_by(value: '0 à 3 mois'))
  product_sku = ProductSku.create!(product: product)
  product_sku.update(variant: Variant.find_by(value: '3 à 6 mois'))
  product_sku = ProductSku.create!(product: product)
  product_sku.update(variant: Variant.find_by(value: '6 à 12 mois'))

  product = Product.create!(
    name_fr: 'Top vêtement fille',
    name_en: 'Great girl cloth',
    description_short: "Un top vetement fille qui vaut vraiment le coup et que tout\
    le monde devrait porter parce qu'il est vraiment bien",
    ht_price_cents: 1200,
    weight: 500,
    ht_buying_price_cents: 1000,
    seo_title: 'Top vetement fille',
    meta_description: "Un top vetement fille qui vaut vraiment le coup et que tout\
    le monde devrait porter parce qu'il est vraiment bien",
    keywords: %w[top vetement fille]
  )
  product_sku = ProductSku.create!(product: product)
  product_sku.update(variant: Variant.find_by(value: '0 à 3 mois'))
  product_sku = ProductSku.create!(product: product)
  product_sku.update(variant: Variant.find_by(value: '3 à 6 mois'))
  product_sku = ProductSku.create!(product: product)
  product_sku.update(variant: Variant.find_by(value: '6 à 12 mois'))

  product = Product.create!(
    name_fr: 'Livre et arbre',
    name_en: 'Book and tree',
    description_short: "Un top bundle livre + arbre qui vaut vraiment le coup et que tout\
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
  product.images.attach(io: File.open('lib/assets/certificate-background.jpg'),
                        filename: 'certificate-background.jpg', content_type: 'image/jpg')
  product.certificate_background.attach(io: File.open('lib/assets/certificate-background.jpg'),
                                        filename: 'certificate-background.jpg',
                                        content_type: 'image/jpg')
  ProductSku.create!(product: product)

  product = Product.create!(
    name_fr: 'Arbre',
    name_en: 'Top Tree',
    description_short: "Un arbre qui vaut vraiment le coup et que tout\
    le monde devrait acheter parce qu'il est vraiment bien",
    ht_price_cents: 500,
    product_type: 2,
    ht_buying_price_cents: 400,
    seo_title: 'Super Top arbre',
    color_certificate: '#ff0000',
    meta_description: "Un arbre qui vaut vraiment le coup et que tout\
    le monde devrait acheter parce qu'il est vraiment bien",
    keywords: %w[top bundle livre arbre]
  )
  product.images.attach(io: File.open('lib/assets/certificate-background.jpg'),
                        filename: 'certificate-background.jpg', content_type: 'image/jpg')
  product.certificate_background.attach(io: File.open('lib/assets/certificate-background.jpg'),
                                        filename: 'certificate-background.jpg',
                                        content_type: 'image/jpg')
  ProductSku.create!(product: product)

  Product.all.each do |p|
    p.images.attach(io: File.open('lib/assets/tree.jpeg'),
                   filename: 'tree.jpeg', content_type: 'image/jpeg')
    p.background_image.attach(io: File.open('lib/assets/tree.jpeg'),
                   filename: 'tree.jpeg', content_type: 'image/jpeg')
    p.images.attach(io: File.open('lib/assets/book.jpg'),
                   filename: 'book.jpeg', content_type: 'image/jpeg')
    8.times do
      Categorization.find_or_create_by!(product: p, category: Category.all.sample)
    end
    p.save
  end

  ProductSku.all.each do |sku|
    2.times { StockEntry.create!(product_sku: sku, quantity: rand(1..10)) }
  end

  TreePlantation.create!(
    project_name: 'Alta Huayabamba, San Martin, Pérou',
    project_type_fr: 'reforestation / agroforesterie',
    project_type_en: 'some tree stuff',
    partner: 'Fundacion Amazonia Viva',
    plantation_uuid: SecureRandom.uuid,
    tree_specie: 'capirona, boleina',
    producer_name: 'Eber Vaqui Saldana',
    trees_quantity: 100,
    base_certificate_uuid: SecureRandom.uuid.slice(0, 10),
    latitude: -13.524001,
    longitude: -72.007402
  )

  Coupon.create!(name: 'MYREDUC', amount_cents: 1000, amount_min_order_cents: 3000,
                 valid_from: Time.zone.today - 2.days, valid_until: Time.zone.today + 20.days)

  Rails.logger.info "#{Product.all.count} products created with SKU and co"

  if Rails.env.development?
    AdminUser.create!(email: 'admin@example.com', password: 'password',
                      password_confirmation: 'password')
  end
end
