# frozen_string_literal: true

# == Schema Information
#
# Table name: variabilizations
#
#  id             :bigint(8)        not null, primary key
#  product_sku_id :bigint(8)
#  variant_id     :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (product_sku_id => product_skus.id)
#  fk_rails_...  (variant_id => variants.id)
#

class Variabilization < ApplicationRecord
  belongs_to :product_sku
  belongs_to :variant

  delegate :category, :value, to: :variants, prefix: true
end
