# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                       :bigint(8)        not null, primary key
#  description_short        :string
#  description_long         :text
#  ht_price_cents           :integer          default(0), not null
#  ht_price_currency        :string           default("EUR"), not null
#  tax_rate                 :decimal(4, 2)    default(20.0), not null
#  weight                   :integer          default(0)
#  product_type             :integer          default("classic"), not null
#  published                :boolean          default(TRUE), not null
#  position                 :integer
#  ht_buying_price_cents    :integer          default(0), not null
#  ht_buying_price_currency :string           default("EUR"), not null
#  seo_title                :string
#  meta_description         :string
#  keywords                 :text             default([]), is an Array
#  slug                     :string
#  producer_latitude        :decimal(11, 8)
#  producer_longitude       :decimal(11, 8)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  name_en                  :string
#  name_fr                  :string
#  position_home            :integer
#  color_certificate        :string
#

FactoryBot.define do
  factory :product do
    name_fr { 'Default name_fr' }
    name_en { 'Default name_en' }
    description_short do
      "Lorem ipsum dolor sit amet, consectetur adipiscing\
      elit. Mauris sit amet ligula non sem ullamcorper commodo."
    end
    ht_price_cents { 1000 }
    seo_title { 'SEO title' }
    meta_description do
      "Lorem ipsum dolor sit amet, consectetur adipiscing\
      elit. Mauris sit amet ligula non sem ullamcorper commodo."
    end
    keywords { %w[top livre arbre] }
  end
end
