# frozen_string_literal: true

require 'rails_helper'

# RSpec.feature 'Classic Product Purchase', type: :feature, js: true do
RSpec.feature 'Classic Product Purchase', type: :feature, js: true do
  include_context 'When authenticated'

  fixtures :categories
  scenario 'A user can buy a classic product' do
    product = create(:product)
    # product = Product.create!(
    #   name_fr: 'Top livre',
    #   name_en: 'Top book',
    #   description_short: "Un top livre qui vaut vraiment le coup et que tout\
    #   le monde devrait lire parce qu'il est vraiment bien",
    #   ht_price_cents: 1000,
    #   weight: 1000,
    #   ht_buying_price_cents: 900,
    #   seo_title: 'Super Top Livre',
    #   meta_description: "Un top livre qui vaut vraiment le coup et que tout\
    #   le monde devrait lire parce qu'il est vraiment bien",
    #   keywords: %w[top livre]
    # )
    file_path = Rails.root.join('spec', 'support', 'assets', 'test-image.jpg')
    file = fixture_file_upload(file_path, 'image/jpg')
    product.images.attach(file)

    product_sku = ProductSku.create!(product: product)
    StockEntry.create!(product_sku: product_sku, quantity: rand(1..10))

    # @user = create(:client, password: 'password', password_confirmation: 'password')
    # login_as(@user)

    visit '/products/top-livre'
    # click_button "Create Widget"
    expect(page).to have_text('Top livre')

    click_on('Ajouter au panier')
    # page.should have_content('Valider mon panier') # async
    click_on('Valider mon panier')

    # find('#go_to_cart').click
    # find_by_id("go_to_cart").click
    # visit cart_path(Order.last)
    visit "carts/#{Order.last.id}"

    expect(page).to have_text('Panier')

    click_on('Valider')
    # save_and_open_screenshot

    fill_in('order_delivery_address_first_name', with: 'John')
    fill_in('order_delivery_address_last_name', with: 'Doe')
    fill_in('order_delivery_address_address_1', with: '101, av de la République')
    fill_in('order_delivery_address_city', with: 'Paris')
    fill_in('order_delivery_address_zip_code', with: '75011')
    select 'France', from: 'order_delivery_address_country', match: :first
    # click_button 'order_general_sales_conditions'
    find(:css, '#order_general_sales_conditions').set(true)
    click_button 'Passer au paiement'

    # save_and_open_screenshot
    expect(page).to have_selector 'h1', text: 'Paiement'
    # fill_in('Email', with: 'a@a.com')
    # fill_in('Password', with: '123456')
    # click_on('Créer mon compte')

    # save_and_open_screenshot
    # click_on('Valider')
    # expect(page).to have_text('Compte client')
    # expect(page).to have_text('Livraison')

    # expect(page).to have_current_path(cart_path(Cart.last))
  end

  # def assert_modal_visible
  #   wait_until { page.find(modal_wrapper_id).visible? }
  # rescue Capybara::TimeoutError
  #   flunk 'Expected modal to be visible.'
  # end
end
