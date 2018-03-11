FactoryBot.define do
  factory :target do
    name              { Faker::Lorem.word }
    department_id     { FactoryBot.create(:department).id }
    category_id       { FactoryBot.create(:category).id }
    unit              { Faker::Lorem.word }
    unit_type         { Target::UNIT_TYPES[1] }
    comments          { Faker::Lorem.sentence }
    year              { 1970 + Random.rand(100) }

    trait :numerical do
      unit_type { Target::UNIT_TYPES[0] }
      compare_to_value { Random.rand(100) }
    end

  end
end
