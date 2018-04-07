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

# Use this in specs where the icon isn't important to the spec (such as other factories). The browser will
# load the default URL instead of attempting to load a file that might not exist
  trait :no_icon do
    to_create {|instance| instance.save(validate: false) }
    icon_file_name   { nil }
    icon_content_type{ nil }
    icon_file_size   { nil }
    icon_updated_at  { nil }
  end
end