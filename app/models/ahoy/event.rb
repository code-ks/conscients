# frozen_string_literal: true

# == Schema Information
#
# Table name: ahoy_events
#
#  id         :integer          not null, primary key
#  visit_id   :integer
#  user_id    :integer
#  name       :string
#  properties :jsonb
#  time       :datetime
#

class Ahoy::Event < ApplicationRecord
  include Ahoy::QueryMethods

  self.table_name = 'ahoy_events'

  belongs_to :visit
  belongs_to :client, optional: true, foreign_key: 'user_id'

  scope :category_events, -> { where("properties->>'category_id' IS NOT NULL") }

  class << self
    def events_current_visit
      Current.visit.events
    end

    def id_last_category_visited
      events_current_visit.category_events.last.properties['category_id']
    end
  end
end
