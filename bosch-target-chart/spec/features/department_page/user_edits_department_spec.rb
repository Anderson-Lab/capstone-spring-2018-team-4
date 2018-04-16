require 'rails_helper'

RSpec.describe "User changes the year", js: true do

  let!(:current_user) { FactoryBot.create(:user) }

  before :each do
    current_user.confirm
    sign_in(current_user)

    @department       = FactoryBot.create(:department)
    @chart            = FactoryBot.create(:chart, department: @department, name: 'Chartmander', year: Time.now.year)

    visit department_path(id: @department.id)
  end

  it 'should update the department' do
      find('#editDepartment').trigger('click')

      fill_in 'department_name', with: 'Dog Department'
      fill_in 'department_abbreviation', with: 'doggo'
      fill_in 'department_charts_attributes_0_name', with: 'doggo chart'
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax

      expect(@department.reload.name).to eq('Dog Department')
      expect(@department.reload.abbreviation).to eq('doggo')
  end

  it 'should update the chart' do
      find('#editDepartment').trigger('click')

      fill_in 'department_name', with: 'Dog Department'
      fill_in 'department_abbreviation', with: 'doggo'
      fill_in 'department_charts_attributes_0_name', with: 'doggo chart'
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax

      expect(@chart.reload.name).to eq('doggo chart')
  end
end