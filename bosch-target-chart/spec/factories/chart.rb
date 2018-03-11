FactoryBot.define do
  factory :chart do
    name { Faker::Lorem.words }
    year { Time.now.year }
  end
end
