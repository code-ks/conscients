# frozen_string_literal: true

# == Schema Information
#
# Table name: blog_posts
#
#  id         :bigint(8)        not null, primary key
#  title_fr   :string
#  title_en   :string
#  body       :text
#  slug       :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BlogPost < ApplicationRecord
  extend Mobility
  translates :title, backend: :column
  translates :body, :slug

  include FriendlyId
  friendly_id :name, use: %i[slugged mobility]

  acts_as_list

  default_scope { i18n.friendly.in_order }
  scope :in_order, -> { order(position: :asc) }
  scope :en, -> { where("title_en <> ''") }
  scope :fr, -> { where("title_fr <> ''") }
end
