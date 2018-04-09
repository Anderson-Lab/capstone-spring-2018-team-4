FactoryBot.define do
  factory :target do
    name              { Faker::Lorem.word }
    department_id     { FactoryBot.create(:department).id }
    category_id       { FactoryBot.create(:category, :no_icon).id }
    unit              { Faker::Lorem.word }
    unit_type         { Target::UNIT_TYPES[1] }
    compare_to_value  { Random.rand(2) }
    comments          { Faker::Lorem.sentence }
    year              { Time.now.year }

    trait :numerical do
      unit_type        { Target::UNIT_TYPES[0] }
      compare_to_value { Random.rand(100) }
      rule             { Target::RULES.sample }
    end
  end
end
