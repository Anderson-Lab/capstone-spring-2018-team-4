FactoryBot.define do
  factory :category do
    name  { Faker::Lorem.word }
    color { Faker::Color.color_name } #if needing to test specific category color, assign in spec
  end
end