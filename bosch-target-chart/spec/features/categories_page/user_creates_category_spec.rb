require 'rails_helper'

RSpec.describe "User views the Categories page", js: true do

  let!(:current_user) { FactoryBot.create(:user) }

  before :each do
    current_user.confirm
    sign_in(current_user)

    visit categories_path
  end

  it 'should create a target' do
    find('#newCategory').click()

    fill_in 'category_name', with: 'Cat Category'
    select I18n.t(:categories)[:chart_colors].values.sample, from: 'category_color'
    attach_file I18n.t(:categories)[:fields][:icon], Rails.root + "spec/example_files/category_icon.png"
    click_button 'Submit'
    wait_for_ajax

    expect(Category.count).to eq(1)
  end
end
