# frozen_string_literal: true

# == Schema Information
#
# Table name: variants
#
#  id         :bigint(8)        not null, primary key
#  category   :integer          default("age"), not null
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  position   :integer
#

class Variant < ApplicationRecord
  has_many :variabilizations, dependent: :destroy
  has_many :product_skus, through: :variabilizations
  has_many :products, through: :product_skus

  acts_as_list

  extend Mobility
  translates :value

  enum category: { age: 0 }

  validates :category, :value, presence: true

  default_scope { i18n.in_order.includes(:text_translations) }
  scope :in_order, -> { order(position: :asc) }

  def to_s
    "#{category.capitalize}: #{value}"
  end
end
