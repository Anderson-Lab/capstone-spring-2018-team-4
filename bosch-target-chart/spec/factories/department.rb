FactoryBot.define do
  factory :department do
    name{ Faker::Lorem.words }
  end
end