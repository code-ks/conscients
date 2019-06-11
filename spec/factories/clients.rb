# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    first_name { 'John' }
    last_name  { 'Doe' }
    email { 'jd@gmail.com' }
  end
end
