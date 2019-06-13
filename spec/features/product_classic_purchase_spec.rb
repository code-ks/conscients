# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Classic Product Purchase', type: :feature, js: true do
  include_context 'With home category'
  include_context 'When authenticated'

  scenario 'A user can buy a classic product' do
    product = create(:product, name_fr: 'Top livre')
    file_path = Rails.root.join('spec', 'support', 'assets', 'classic-product-image.jpg')
    file = fixture_file_upload(file_path, 'image/jpg')
    product.images.attach(file)

    product_sku = ProductSku.create!(product: product)
    StockEntry.create!(product_sku: product_sku, quantity: rand(1..10))

    visit '/products/top-livre'
    expect(page).to have_text('Top livre')

    click_on('Ajouter au panier')
    click_on('Valider mon panier')
    visit "carts/#{Order.last.id}"
    expect(page).to have_text('Panier')

    click_on('Valider')

    fill_in('order_delivery_address_first_name', with: 'John')
    fill_in('order_delivery_address_last_name', with: 'Doe')
    fill_in('order_delivery_address_address_1', with: '101, av de la République')
    fill_in('order_delivery_address_city', with: 'Paris')
    fill_in('order_delivery_address_zip_code', with: '75011')
    select 'France', from: 'order_delivery_address_country', match: :first
    find(:css, '#order_general_sales_conditions').set(true)
    click_button 'Passer au paiement'

    # save_and_open_screenshot
    expect(page).to have_selector 'h1', text: 'Paiement'
  end
end
