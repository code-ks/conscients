# frozen_string_literal: true

# == Schema Information
#
# Table name: product_skus
#
#  id         :bigint(8)        not null, primary key
#  product_id :bigint(8)
#  variant_id :bigint(8)
#  sku        :string           not null
#  quantity   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (variant_id => variants.id)
#

FactoryBot.define do
  factory :product_sku do
  end
end
