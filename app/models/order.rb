# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                     :integer          not null, primary key
#  aasm_state             :string
#  coupon_id              :integer
#  delivery_address_id    :integer
#  billing_address_id     :integer
#  delivery_method        :integer          default(0), not null
#  delivery_fees_cents    :integer          default(0), not null
#  delivery_fees_currency :string           default("EUR"), not null
#  total_price_cents      :integer          default(0), not null
#  total_price_currency   :string           default("EUR"), not null
#  payment_method         :integer          default(0), not null
#  recipient_message      :text
#  customer_note          :text
#  client_id              :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (coupon_id => coupons.id)
#

class Order < ApplicationRecord
  belongs_to :coupon
  belongs_to :delivery_address, class_name: 'Address'
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :client
  has_many :line_items, dependent: :destroy
  has_many :product_skus, through: :line_items

  enum delivery_method: { single_address: 0, email: 1 }
  enum payment_method: { stripe: 0, paypal: 1, bank_transfer: 2 }

  validates :total_price_cents, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :delivery_method, presence: true, inclusion: { in: delivery_methods.keys }
  validates :payment_method, presence: true, inclusion: { in: payment_methods.keys }
  validates :aasm_state, presence: true, inclusion: { in: %w[cart paid delivered] }
end
