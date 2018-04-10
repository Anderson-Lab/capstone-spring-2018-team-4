require 'rails_helper'

RSpec.describe "User views the Categories page", js: true do

  let!(:current_user) { FactoryBot.create(:user) }

  before :each do
    current_user.confirm
    sign_in(current_user)

    @category = FactoryBot.create(:category, 
                                  :fuchsia,
                                  icon: Rack::Test::UploadedFile.new(File.join('spec/example_files', 'category_icon.png'),'image/png'))

    visit categories_path
  end

  it 'should create a category with a new image' do
    find("#editCategory#{@category.id}").click()

    fill_in 'category_name', with: 'Updated Cat Category'
    select I18n.t(:categories)[:chart_colors][:light_blue], from: 'category_color'
    attach_file 'iconInput', Rails.root + "spec/example_files/ruby.png"
    click_button 'Submit'
    wait_for_ajax

    @category.reload
    expect(@category.name).to eq('Updated Cat Category')
    expect(@category.color).to eq(Category::COLOR_HEX_VALUES_HASH[:light_blue])
    expect(@category.icon_file_name).to eq('ruby.png')
  end

  it 'should create a category without a new image' do
    find("#editCategory#{@category.id}").click()

    fill_in 'category_name', with: 'Updated Cat Category'
    select I18n.t(:categories)[:chart_colors][:light_blue], from: 'category_color'
    click_button 'Submit'
    wait_for_ajax

    @category.reload
    expect(@category.name).to eq('Updated Cat Category')
    expect(@category.color).to eq(Category::COLOR_HEX_VALUES_HASH[:light_blue])
    expect(@category.icon_file_name).to eq('category_icon.png')
  end
end
