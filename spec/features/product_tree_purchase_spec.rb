# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Tree Product Purchase', type: :feature, js: true do
  include_context 'With home category'
  include_context 'When authenticated'

  scenario 'A user can buy a tree product' do
    create(:category, slug: 'offrir-un-arbre-cadeau')
    create(:tree_plantation)
    product = create(:product,
                     name_fr: 'Mon arbre',
                     product_type: 'tree',
                     color_certificate: '#32B796')
    file_path = Rails.root.join('spec', 'support', 'assets', 'tree.png')
    file = fixture_file_upload(file_path, 'image/png')
    product.images.attach(file)
    create(:product_sku, product: product)

    visit '/products/mon-arbre'
    expect(page).to have_text('Mon arbre')
    # save_and_open_screenshot

    fill_in('line_item_recipient_name', with: 'John')
    fill_in('line_item_recipient_message', with: 'Message')
    click_on('Ajouter au panier')
    click_on('Valider mon panier')
    visit "carts/#{Order.last.id}"
    expect(page).to have_text('Panier')

    click_on('Valider')

    fill_in('order_billing_address_first_name', with: 'John')
    fill_in('order_billing_address_last_name', with: 'Doe')
    fill_in('order_billing_address_address_1', with: '101, av de la République')
    fill_in('order_billing_address_city', with: 'Paris')
    fill_in('order_billing_address_zip_code', with: '75011')
    # select 'France', from: 'order_delivery_address_country', match: :first
    find(:css, '#order_general_sales_conditions').set(true)
    click_button 'Passer au paiement'
    line_item = Order.last.line_items.last
    expect(line_item.certificate_number).to eq(
      "#{line_item.tree_plantation.base_certificate_uuid}-001"
    )
    # save_and_open_screenshot
    expect(page).to have_selector 'h1', text: 'Paiement'
  end
end
