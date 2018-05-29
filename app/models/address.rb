# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id           :bigint(8)        not null, primary key
#  first_name   :string
#  last_name    :string
#  company      :string
#  address_1    :string
#  address_2    :string
#  city         :string
#  zip_code     :string
#  country      :string           default("FR")
#  title        :string
#  address_type :integer          default("postal"), not null
#  email        :string
#  client_id    :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#

class Address < ApplicationRecord
  belongs_to :client
  has_many :delivery_orders, class_name: 'Order',
            foreign_key: 'delivery_address_id', dependent: :nullify
  has_many :billing_orders, class_name: 'Order',
           foreign_key: 'billing_address_id', dependent: :nullify

  enum address_type: { postal: 0, email: 1 }

  validates :email, presence: true, allow_blank: false, if: :email?
  validates :first_name, :last_name, :address_1, :city, :zip_code, :country,
            presence: true, allow_blank: false, if: :postal?

  def to_s
    "#{address_1} #{zip_code} #{city}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
