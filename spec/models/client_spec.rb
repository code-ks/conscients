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
#  payment_date           :datetime
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

require 'rails_helper'

RSpec.describe Order, type: :model do
  # context 'A user' do
  #   it 'can update his password' do
  #     client = FactoryBot.create(:client, email: 'new@gmail.com', password: 'password')
  #     update_with_password(client, {current_password: 'password', password: 'newpassword'})
  #     expect(client.valid_password?('newpassword')).to be true
  #   end

  #   it 'can not update his password if his current_password is wrong' do
  #     client = FactoryBot.create(:client, email: 'new@gmail.com', password: 'password')
  #     update_with_password(client, {current_password: 'random', password: 'newpassword'})
  #     expect(client.valid_password?('newpassword')).to be false
  #   end
  # end

  # def update_with_password(client, params)
  #   current_password = params.delete(:current_password)

  #   if params[:password].blank?
  #     params.delete(:password)
  #     params.delete(:password_confirmation) if params[:password_confirmation].blank?
  #   end

  #   result = if params[:password].blank?
  #     false
  #   elsif client.valid_password?(current_password)
  #     result = client.update(password: params[:password])
  #     # bypass_sign_in(client)
  #     result
  #   else
  #     client.assign_attributes(password: params[:password])
  #     # bypass_sign_in(client)
  #     client.valid?
  #     client.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
  #     false
  #   end

  #   params.delete(:password)
  #   result
  # end
end
