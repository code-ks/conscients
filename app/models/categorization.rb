# frozen_string_literal: true

# == Schema Information
#
# Table name: categorizations
#
#  id          :bigint(8)        not null, primary key
#  category_id :bigint(8)
#  product_id  :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (product_id => products.id)
#

class Categorization < ApplicationRecord
  belongs_to :category
  belongs_to :product

  validates :product_id, uniqueness: { scope: :category_id }
end
