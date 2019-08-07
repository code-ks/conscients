# frozen_string_literal: true

# == Schema Information
#
# Table name: clients
#
#  id                     :bigint(8)        not null, primary key
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
#  provider               :string
#  uid                    :string
#  stripe_customer_id     :string
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_type        :string
#  invited_by_id          :bigint(8)
#  invitations_count      :integer          default(0)
#  can_debug              :boolean          default(FALSE), not null
#

class Client < ApplicationRecord
  has_many :coupons, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :cart, -> { in_cart }, class_name: 'Order'
  has_many :addresses, dependent: :destroy
  has_one :email_address, -> { order(created_at: :desc).email }, class_name: 'Address'
  has_one :postal_address, -> { order(created_at: :desc).postal }, class_name: 'Address'
  has_one :delivery_address, -> { order(created_at: :desc).delivery }, class_name: 'Address'
  has_one :billing_address, -> { order(created_at: :desc).billing }, class_name: 'Address'
  has_many :line_items, through: :orders
  has_many :product_skus, through: :line_items
  has_many :products, through: :product_skus
  has_many :tree_plantations, through: :line_items
  has_many :visits, dependent: :destroy, class_name: 'Ahoy::Visit', foreign_key: 'user_id'
  has_many :events, dependent: :destroy, class_name: 'Ahoy::Event', foreign_key: 'user_id'

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  validates :email, :encrypted_password, presence: true

  # Subscribe if accepted newsletter
  after_create :subscribe_to_mailing_list, if: :newsletter_subscriber?

  class << self
    def from_facebook_oauth(auth)
      find_or_create_by(email: auth.info.email) do |client|
        client.provider = auth.provider
        client.uid = auth.uid
        client.password = Devise.friendly_token[0, 20]
        client.email = auth.info.email
        client.first_name = auth.info.first_name
        client.last_name = auth.info.last_name
      end
    end
  end

  def to_s
    email
  end

  # Build markers for producers and tree plantations for the client admin
  # rubocop:disable Metrics/AbcSize
  def markers
    line_items.paid.includes(:product_sku).map do |line_item|
      line_item.producer_marker if line_item.producer_marker?
      line_item.tree_plantation_marker if line_item.tree_marker?
    end.uniq
  end
  # rubocop:enable Metrics/AbcSize

  def tree_species_planted
    tree_plantations.pluck(:tree_specie).uniq
  end

  def quantity_of_trees_planted
    line_items.paid.certificable.sum(&:quantity)
  end

  def tonne_co2_captured
    quantity_of_trees_planted.fdiv(3.5).round(2)
  end

  # Manage 2 Mailchimp lists: English and French
  def subscribe_to_mailing_list
    return unless Rails.env.production?

    list_id = I18n.locale == :fr ? '53e2a5b32b' : 'fde901016c'
    SubscribeClientToMailingListJob.perform_later(list_id, id)
  end

  def lower_case_md5_hashed_email
    Digest::MD5.hexdigest(email.downcase)
  end

  def full_name
    if first_name && last_name
      "#{first_name} #{last_name}"
    elsif addresses.any?
      addresses.last.full_name
    end
  end
end
