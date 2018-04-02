require 'rails_helper'

RSpec.describe "User views the Categories page", js: true do

  let!(:current_user) { FactoryBot.create(:user) }

  before :each do
    current_user.confirm
    sign_in(current_user)

    FactoryBot.create(:chart, name: 'Chartmander', year: Time.now.year)

    visit dashboard_path
  end

  context 'from a dashboard page with charts' do
    it 'should show the category page' do
      find('#manageCategories').trigger('click')

      expect(page).to have_selector('#categoriesContainer')
    end
  end

  context 'from a dashboard page without any charts' do
    it 'should show the category page' do
      find('#yearSelectButton').click
      find('a.dropdown-item', text: Time.now.year + 1).click
      find('#manageCategories').trigger('click')

      expect(page).to have_selector('#categoriesContainer')
    end
  end
end
