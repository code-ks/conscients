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
#  delivery_method        :integer          default("postal"), not null
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
#  payment_details        :jsonb
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

  accepts_nested_attributes_for :line_items

  monetize :total_price_cents, :ttc_price_cents, :delivery_fees_cents,
           :ttc_price_all_included_cents, :coupon_discount_cents, :ttc_price_with_coupon_cents,
           :current_delivery_fees_cents, :main_delivery_fees_cents, :printing_fees_cents

  enum delivery_method: { postal: 0, email: 1 }
  enum payment_method: { stripe: 0, paypal: 1, bank_transfer: 2 }
  enum aasm_state: { in_cart: 0, paid: 1, fulfilled: 2 }

  validates :total_price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :delivery_method, presence: true, inclusion: { in: delivery_methods.keys }
  validates :payment_method, presence: true, inclusion: { in: payment_methods.keys }
  validates :aasm_state, presence: true, inclusion: { in: aasm_states.keys }
  validate :eligible_to_coupon

  delegate :client, :product, :amount_min_order, :valid_from, :valid_until,
           :amount_cents, :percentage, to: :coupon, prefix: true
  delegate :email, :stripe_customer_id, to: :client, prefix: true

  include AASM
  aasm enum: true do
    state :in_cart, initial: true
    state :paid
    state :fullfilled

    event :pay, after: :notify_somebody do
      transitions from: :in_cart, to: :paid
    end
  end

  def ttc_price_cents
    line_items.sum(&:ttc_price_cents)
  end

  def coupon_discount_cents
    return 0 unless coupon
    coupon_percentage ? ttc_price_cents * coupon_percentage : coupon_amount_cents
  end

  def ttc_price_with_coupon_cents
    ttc_price_cents - coupon_discount_cents
  end

  def current_delivery_fees_cents
    return 0 if email?
    main_delivery_fees_cents + printing_fees_cents
  end

  def main_delivery_fees_cents
    DELIVERY_FEES.select { |weight| weight.member?(total_weight) }.values.dig(0, symbol_region) || 0
  end

  def printing_fees_cents
    return 0 if email?
    line_items.inject(0) do |sum, line_item|
      line_item.certificable? ? sum + PRINTING_FEES * line_item.quantity : sum
    end
  end

  def total_weight
    line_items.includes(:product_sku).sum(&:product_weight) || 0
  end

  def symbol_region
    if delivery_address&.country == ('FR' || nil)
      :france
    elsif EUROPE.include?(delivery_address&.country)
      :europe
    else
      :world
    end
  end

  def ttc_price_all_included_cents
    ttc_price_with_coupon_cents + current_delivery_fees_cents
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

  def set_email_delivery_address
    delivery_address || client.email_address || build_delivery_address(email: client.email)
  end

  def set_postal_delivery_address
    delivery_address || client.postal_address || build_delivery_address
  end

  def set_billing_address
    billing_address || client.postal_address || build_billing_address
  end

  def to_correct_delivery_type(params)
    if params == 'postal'
      postal!
    elsif params == 'email'
      email!
    end
  end

  private

  def eligible_to_coupon
    return unless coupon &&
                  (not_coupon_client || no_eligible_product_in_cart ||
                    order_too_small_for_coupon || coupon_not_valid)
  end

  def not_coupon_client
    coupon_client &&  coupon_client != Current&.visit&.client
  end

  def no_eligible_product_in_cart
    coupon_product && !products.include?(coupon_product)
  end

  def order_too_small_for_coupon
    ttc_price < coupon_amount_min_order
  end

  def coupon_not_valid
    !Time.zone.today.between?(coupon_valid_from, coupon_valid_until)
  end
end
