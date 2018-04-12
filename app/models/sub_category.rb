# frozen_string_literal: true

# == Schema Information
#
# Table name: sub_categories
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  slug        :string           not null
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#

class SubCategory < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :products

  include FriendlyId
  friendly_id :name, use: %i[finders slugged scoped], scope: :category

  validates :name, presence: true, uniqueness: { scope: :category }
end
