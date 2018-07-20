# frozen_string_literal: true

# == Schema Information
#
# Table name: variants
#
#  id         :bigint(8)        not null, primary key
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  position   :integer
#

class Variant < ApplicationRecord
  has_many :product_skus, dependent: :destroy
  has_many :products, through: :product_skus

  acts_as_list

  extend Mobility
  translates :value

  validates :value, presence: true

  default_scope { i18n.in_order.includes(:text_translations) }
  scope :in_order, -> { order(position: :asc) }
  scope :in_stock, -> { where.not(product_skus: { quantity: 0 }) }

  delegate :to_s, to: :value
end
