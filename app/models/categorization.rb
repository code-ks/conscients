# frozen_string_literal: true

# == Schema Information
#
# Table name: categorizations
#
#  id              :integer          not null, primary key
#  sub_category_id :integer
#  product_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (sub_category_id => sub_categories.id)
#

class Categorization < ApplicationRecord
  belongs_to :sub_category
  belongs_to :product
end
