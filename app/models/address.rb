# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  first_name :string           not null
#  last_name  :string           not null
#  company    :string
#  address_1  :string           not null
#  address_2  :string
#  city       :string           not null
#  zip_code   :string           not null
#  country    :string           default("France"), not null
#  title      :string
#  client_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
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

  validates :first_name, :last_name, :address_1, :city, :zip_code, :country, presence: true
end
