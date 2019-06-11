# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name_fr { 'Top livre' }
    name_en { 'Top book' }
    description_short do
      "Un top livre qui vaut vraiment le coup et que tout\
      le monde devrait lire parce qu'il est vraiment bien"
    end
    ht_price_cents { 1000 }
    weight { 1000 }
    ht_buying_price_cents { 900 }
    seo_title { 'Super Top Livre' }
    meta_description do
      "Un top livre qui vaut vraiment le coup et que tout\
      le monde devrait lire parce qu'il est vraiment bien"
    end
    keywords { %w[top livre] }
  end
end
