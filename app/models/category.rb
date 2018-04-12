# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  has_many :sub_categories, dependent: :nullify
  has_many :categorizations, through: :sub_categories
  has_many :products, through: :categorizations

  include FriendlyId
  friendly_id :name, use: %i[finders slugged]

  validates :name, presence: true, uniqueness: true
end
