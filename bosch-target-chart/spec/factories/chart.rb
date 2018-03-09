FactoryBot.define do
  factory :chart do
    name { Faker::Lorem.words }
    sequence(:year) { |n| 1970 + n }
  end
end