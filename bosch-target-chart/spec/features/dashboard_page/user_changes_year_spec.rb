require 'rails_helper'

RSpec.describe "User changes the year", js: true do

  let!(:current_user) { FactoryBot.create(:user) }

  before :each do
    current_user.confirm
    sign_in(current_user)

    @chart_last_year  = FactoryBot.create(:chart, name: 'Char har hart', year: Time.now.year - 1)
    @chart_this_year  = FactoryBot.create(:chart, name: 'Chartmander', year: Time.now.year)

    visit dashboard_path
  end

  context 'to a previous year with charts' do
    it 'should load the charts for the year' do
      find('#yearSelectButton').click
      find('a.dropdown-item', text: Time.now.year - 1).click
      wait_for_ajax

      expect(page).to have_selector('.chart-header', text: 'Char har hart')
    end
  end

  context 'to a year with no charts' do
    it 'should load the new chart page' do
      find('#yearSelectButton').click
      find('a.dropdown-item', text: Time.now.year + 1).click
      wait_for_ajax

      expect(page).to have_content(I18n.t('charts.new_year.header', year: Time.now.year + 1))
    end
  end
end
