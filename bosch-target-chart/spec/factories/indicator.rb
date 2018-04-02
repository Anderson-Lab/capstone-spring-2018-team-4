FactoryBot.define do
  factory :indicator do
    target_id         { FactoryBot.create(:target).id }
    name              { Faker::Lorem.word }
    value             { rand(100) }
    color             { Indicator::COLORS.sample }
  end
end
