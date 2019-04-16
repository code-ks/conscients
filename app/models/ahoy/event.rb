# frozen_string_literal: true

# == Schema Information
#
# Table name: ahoy_events
#
#  id         :bigint(8)        not null, primary key
#  visit_id   :bigint(8)
#  user_id    :bigint(8)
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
      Current.visit&.events
    end

    # Events linked to the current visit, linked to a category (category_id not null),
    # we select the last one and find its category_id
    def id_last_category_visited
      events_current_visit&.category_events&.last&.properties&.dig('category_id') ||
        Category.home.id
    end
  end
end
