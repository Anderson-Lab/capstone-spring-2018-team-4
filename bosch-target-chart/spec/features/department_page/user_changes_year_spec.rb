require 'rails_helper'

RSpec.describe "User changes the year", js: true do

  let!(:current_user) { FactoryBot.create(:user) }

  before :each do
    current_user.confirm
    sign_in(current_user)

    @department       = FactoryBot.create(:department)
    @chart_last_year  = FactoryBot.create(:chart, department: @department, name: 'Char har hart', year: Time.now.year - 1)
    @chart_this_year  = FactoryBot.create(:chart, department: @department, name: 'Chartmander', year: Time.now.year)
    @target           = FactoryBot.create(:target, department: @department, year: @chart_last_year.year)

    visit department_path(@department)
  end

  it 'should load the charts for the year' do
    find('#yearSelectButton').click
    find('a.dropdown-item', text: Time.now.year - 1).click
    wait_for_ajax

    expect(page).to have_selector('.chart-header', text: 'Char har hart')
  end

  it 'should load the targets for the year' do
    find('#yearSelectButton').click
    find('a.dropdown-item', text: Time.now.year - 1).click
    wait_for_ajax

    expect(page).to have_content(@target.name)
  end
end
