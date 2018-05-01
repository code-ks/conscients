# frozen_string_literal: true

# == Schema Information
#
# Table name: ahoy_visits
#
#  id               :bigint(8)        not null, primary key
#  visit_token      :string
#  visitor_token    :string
#  user_id          :bigint(8)
#  ip               :string
#  user_agent       :text
#  referrer         :text
#  referring_domain :string
#  search_keyword   :string
#  landing_page     :text
#  browser          :string
#  os               :string
#  device_type      :string
#  country          :string
#  region           :string
#  city             :string
#  utm_source       :string
#  utm_medium       :string
#  utm_term         :string
#  utm_content      :string
#  utm_campaign     :string
#  started_at       :datetime
#

class Ahoy::Visit < ApplicationRecord
  self.table_name = 'ahoy_visits'

  has_many :events, class_name: 'Ahoy::Event', dependent: :destroy
  belongs_to :client, optional: true, foreign_key: 'user_id'
  alias_attribute :user, :client
end
