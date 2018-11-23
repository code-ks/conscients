# frozen_string_literal: true

# == Schema Information
#
# Table name: coupons
#
#  id                        :bigint(8)        not null, primary key
#  product_id                :bigint(8)
#  client_id                 :bigint(8)
#  percentage                :integer
#  amount_cents              :integer
#  amount_currency           :string           default("EUR"), not null
#  name                      :string           not null
#  amount_min_order_cents    :integer          default(0), not null
#  amount_min_order_currency :string           default("EUR"), not null
#  valid_from                :date             not null
#  valid_until               :date             not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (product_id => products.id)
#

class Coupon < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :client, optional: true
  has_many :orders, dependent: :nullify

  monetize :amount_cents, allow_nil: true
  monetize :amount_min_order_cents

  validates :name, :valid_from, :valid_until, presence: true
  validate :amount_or_percentage

  def list_of_clients
    orders.pluck(:client_id)
  end

  private

  def amount_or_percentage
    return if !!amount ^ !!percentage

    errors.add(:base, I18n.t('activerecord.errors.models.coupon.amount_or_percentage'))
  end
end
