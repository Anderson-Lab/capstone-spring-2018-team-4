FactoryBot.define do
  factory :target do
    name              { Faker::Lorem.word }
    department_id     { FactoryBot.create(:department).id }
    category_id       { FactoryBot.create(:category).id }
    unit              { Faker::Lorem.word }
    unit_type         { Target::UNIT_TYPES[1] }
    update_frequency  { [I18n.t(:targets)[:fields][:update_frequency][:monthly], I18n.t(:targets)[:fields][:update_frequency][:yearly]].sample }
    comments          { Faker::Lorem.sentence }
    year              { Time.now.year }

    trait :numerical do
      unit_type { Target::UNIT_TYPES[0] }
      compare_to_value { Random.rand(100) }
    end

  end
end
