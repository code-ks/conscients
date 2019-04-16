# frozen_string_literal: true

# == Schema Information
#
# Table name: blog_posts
#
#  id               :bigint(8)        not null, primary key
#  content          :text
#  slug             :string
#  seo_title        :string
#  meta_description :string
#  published_fr     :boolean          default(FALSE), not null
#  published_en     :boolean          default(FALSE), not null
#  position         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  category         :string
#  title            :string
#

class BlogPost < ApplicationRecord
  # Main image of the article
  has_one_attached :main_image
  # Image to display on the home page
  has_one_attached :image_for_home

  extend Mobility
  translates :content, :slug, :seo_title, :meta_description, :category, :title

  # Cf friendly_id_mobility gem to understand how to use both together
  include FriendlyId
  friendly_id :seo_title, use: %i[slugged mobility]

  acts_as_list
  paginates_per 5

  validates :content_fr, :seo_title_fr, :meta_description_fr, :slug_fr, :category_fr, :title_fr,
            presence: true, if: :published_fr?
  validates :content_en, :seo_title_en, :meta_description_en, :slug_en, :category_en, :title_en,
            presence: true, if: :published_en?

  default_scope { i18n.friendly.in_order.includes(:image_for_home_attachment) }
  scope :in_order, -> { order(position: :asc) }
  # Can be published in one language but not the other
  scope :published_en, -> { where(published_en: true) }
  scope :published_fr, -> { where(published_fr: true) }
end
