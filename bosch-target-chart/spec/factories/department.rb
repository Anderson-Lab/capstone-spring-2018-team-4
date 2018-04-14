FactoryBot.define do
  factory :department do
    name        { Faker::Lorem.word }
    abbreviation{ Faker::Lorem.word }
  end
end