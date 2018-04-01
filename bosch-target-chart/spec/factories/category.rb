FactoryBot.define do
  factory :category do
    name  { Faker::Lorem.word }
    color { Category::COLOR_HEX_VALUES_HASH.values.sample }
  end
end