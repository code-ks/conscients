# frozen_string_literal: true

# == Schema Information
#
# Table name: clients
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  first_name             :string
#  last_name              :string
#  phone_number           :string
#  newsletter_subscriber  :boolean          default(TRUE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Client < ApplicationRecord
  has_many :coupons, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :line_items, through: :orders
  has_many :product_skus, through: :line_items
  has_many :products, through: :product_skus
  has_many :tree_plantations, through: :line_items
  has_many :visits, dependent: :destroy, class_name: 'Ahoy::Visit', foreign_key: 'user_id'
  has_many :events, dependent: :destroy, class_name: 'Ahoy::Event', foreign_key: 'user_id'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, :encrypted_password, presence: true
end
