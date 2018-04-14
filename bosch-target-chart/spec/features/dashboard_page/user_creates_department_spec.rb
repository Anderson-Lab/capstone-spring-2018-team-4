require 'rails_helper'

RSpec.describe "User views the Categories page", js: true do

  let!(:current_user) { FactoryBot.create(:user) }

  context 'with charts for the current year and next year' do
    before :each do
      current_user.confirm
      sign_in(current_user)

      @chart_this_year  = FactoryBot.create(:chart, name: 'Plant Chart this year', year: Time.now.year)
      @chart_next_year  = FactoryBot.create(:chart, name: 'Plant Chart next year', year: Time.now.year + 1)

      visit dashboard_path
    end

    it 'should create a department and two charts' do
      find('#newDepartment').click()

      fill_in 'department_name', with: 'Dog Department'
      fill_in 'department_abbreviation', with: 'doggo'
      fill_in 'department_charts_attributes_0_name', with: 'doggo chart'
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax

      expect(Department.count).to eq(1)
      expect(Department.first.charts.count).to eq(2)
    end
  end

  context 'with charts for the current year only' do
    before :each do
      current_user.confirm
      sign_in(current_user)

      @chart_this_year  = FactoryBot.create(:chart, name: 'Plant Chart this year', year: Time.now.year)

      visit dashboard_path
    end

    it 'should create a department and one chart' do
      find('#newDepartment').click()

      fill_in 'department_name', with: 'Dog Department'
      fill_in 'department_abbreviation', with: 'doggo'
      fill_in 'department_charts_attributes_0_name', with: 'doggo chart'
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax

      expect(Department.count).to eq(1)
      expect(Department.first.charts.count).to eq(1)
    end
  end
end