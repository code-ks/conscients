# frozen_string_literal: true

# == Schema Information
#
# Table name: coupons
#
#  id          :bigint(8)        not null, primary key
#  product_id  :bigint(8)
#  client_id   :bigint(8)
#  percentage  :boolean          default(FALSE), not null
#  amount      :integer          not null
#  valid_from  :date             not null
#  valid_until :date             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
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

  validates :percentage, :amount, :valid_from, :valid_until, presence: true
end
