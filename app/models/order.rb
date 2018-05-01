# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                     :bigint(8)        not null, primary key
#  aasm_state             :integer          not null
#  coupon_id              :bigint(8)
#  delivery_address_id    :bigint(8)
#  billing_address_id     :bigint(8)
#  delivery_method        :integer          default("single_address"), not null
#  delivery_fees_cents    :integer          default(0), not null
#  delivery_fees_currency :string           default("EUR"), not null
#  total_price_cents      :integer          default(0), not null
#  total_price_currency   :string           default("EUR"), not null
#  payment_method         :integer          default("stripe"), not null
#  recipient_message      :text
#  customer_note          :text
#  client_id              :bigint(8)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (billing_address_id => addresses.id)
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (coupon_id => coupons.id)
#  fk_rails_...  (delivery_address_id => addresses.id)
#

class Order < ApplicationRecord
  belongs_to :coupon, optional: true
  belongs_to :delivery_address, class_name: 'Address', optional: true
  belongs_to :billing_address, class_name: 'Address', optional: true
  belongs_to :client, optional: true
  has_many :line_items, dependent: :destroy
  has_many :product_skus, through: :line_items
  has_many :products, through: :product_skus

  enum delivery_method: { single_address: 0, email: 1 }
  enum payment_method: { stripe: 0, paypal: 1, bank_transfer: 2 }
  enum aasm_state: { in_cart: 0, paid: 1, fulfilled: 2 }

  validates :total_price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :delivery_method, presence: true, inclusion: { in: delivery_methods.keys }
  validates :payment_method, presence: true, inclusion: { in: payment_methods.keys }
  validates :aasm_state, presence: true, inclusion: { in: aasm_states.keys }

  include AASM
  aasm enum: true do
    state :in_cart, initial: true
    state :paid
    state :fullfilled
  end

  def ttc_price
    line_items.sum(&:ttc_price)
  end

  def last_added
    line_items.last
  end

  def recipient_last_product
    last_added&.recipient_name
  end

  def items_number
    line_items.count
  end

  def tree_only?
    products.pluck(:product_type).uniq == ['tree']
  end
end
