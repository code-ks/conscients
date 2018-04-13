# frozen_string_literal: true

# == Schema Information
#
# Table name: categorizations
#
#  id          :integer          not null, primary key
#  category_id :integer
#  product_id  :integer
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
end
