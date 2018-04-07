# Note about icons:
#   To use an icon in a controller spec, you have to specifically upload it
#   Example params for icon:
#     icon: Rack::Test::UploadedFile.new(File.join('spec/example_files', 'category_icon.png'),'image/png')
FactoryBot.define do
  factory :category do
    name  { Faker::Lorem.word }
    color { Category::COLOR_HEX_VALUES_HASH.values.sample }
    icon_file_name   { Faker::Lorem.word + '.png' }
    icon_content_type{ 'image/png' }
    icon_file_size   { Random.rand(100000) }
    icon_updated_at  { Time.now }
  end

  trait :fuchsia do
    color { Category::COLOR_HEX_VALUES_HASH[:fuchsia] }
  end

  trait :no_icon do
    icon_file_name   { nil }
    icon_content_type{ nil }
    icon_file_size   { nil }
    icon_updated_at  { nil }
  end
end