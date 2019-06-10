# frozen_string_literal: true

# Factory.define :user do |f|
#   f.email { Faker::Internet.email }
#   f.first_name { Faker::Name.first_name }
#   f.last_name { Faker::Name.last_name }
#   f.phone { Faker::PhoneNumber.phone_number }
#   f.password "foobar"
# end
# FactoryBot.define :client do |f|
#   f.email { Faker::Internet.email }
#   f.first_name { Faker::Name.first_name }
#   f.last_name { Faker::Name.last_name }
#   f.password "foobar"
# end

# FactoryBot.define do
#   factory :client do
#     first_name { "John" }
#     last_name  { "Doe" }
#     # admin { false }
#   end
# end
FactoryBot::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess
end
