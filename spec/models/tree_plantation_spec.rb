# frozen_string_literal: true

# == Schema Information
#
# Table name: tree_plantations
#
#  id                    :bigint(8)        not null, primary key
#  project_name          :string           not null
#  project_type          :string
#  partner               :string           not null
#  plantation_uuid       :string
#  base_certificate_uuid :string           not null
#  latitude              :decimal(11, 8)   not null
#  longitude             :decimal(11, 8)   not null
#  tree_specie           :string
#  producer_name         :string
#  trees_quantity        :integer          default(0), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  base_tree_quantity    :integer
#  is_full               :boolean          default(FALSE)
#  certificate_counter   :integer          default(0), not null
#

require 'rails_helper'

RSpec.describe TreePlantation, type: :model do
  it 'is has a tree quantities equal to base quantity at creation' do
    tree_plantation = build(:tree_plantation)
    expect(tree_plantation.trees_quantity).to eq(100)
  end

  it 'generates a unique and sequential certif number each time .generate_certificate_number' do
    product = create(:product,
                     name_fr: 'Mon arbre',
                     product_type: 'tree',
                     color_certificate: '#32B796')
    product_sku = create(:product_sku, product: product)
    tree_plantation = create(:tree_plantation, base_tree_quantity: 100)
    order = create(:order)
    line_item_hash = {
      tree_plantation: tree_plantation,
      product_sku: product_sku,
      order: order,
      quantity: 1
    }
    # build() does not persist line_item > case of multiple line
    # items instantiated simultaneously but not yet persisted
    build(:line_item, line_item_hash)
    first_certif_num = tree_plantation.generate_certificate_number
    build(:line_item, line_item_hash)
    second_certif_num = tree_plantation.generate_certificate_number
    expect(first_certif_num).not_to eq(second_certif_num)
    expect([first_certif_num, second_certif_num].max).to eq(second_certif_num)
  end

  it 'first_with_needed_quantity works as expected' do
    tp_ten_first = create(:tree_plantation, trees_quantity: 10,
      project_name: 'Amazonia', project_type: 'type type', partner: 'La Fondacion',
      latitude: 0.434079e2, longitude: 0.37008e1, base_certificate_uuid: 'ABC')
    tp_ten_second = create(:tree_plantation, trees_quantity: 10,
      project_name: 'Amazonia', project_type: 'type type', partner: 'La Fondacion',
      latitude: 0.434079e2, longitude: 0.37008e1, base_certificate_uuid: 'ABC')
    tp_hundred = create(:tree_plantation, trees_quantity: 100,
      project_name: 'Amazonia', project_type: 'type type', partner: 'La Fondacion',
      latitude: 0.434079e2, longitude: 0.37008e1, base_certificate_uuid: 'ABC')
    expect(TreePlantation.first_with_needed_quantity(1)).to eq(tp_ten_first)
    expect(TreePlantation.first_with_needed_quantity(11)).to eq(tp_hundred)
  end
end
