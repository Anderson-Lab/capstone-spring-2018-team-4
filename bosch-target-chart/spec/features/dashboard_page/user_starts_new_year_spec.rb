require 'rails_helper'

RSpec.describe "User starts a new year", js: true do

  let!(:current_user) { FactoryBot.create(:user) }

  before :each do
    current_user.confirm
    sign_in(current_user)
  end

  context 'with no existing charts present' do
    context 'and user starts the current year' do
      it 'should redirect to the Dashboard for the current year' do
        @year       = Time.now.year
        @department = FactoryBot.create(:department, abbreviation: 'Departed')

        visit dashboard_path

        click_link I18n.t('charts.new_year.start_button', year: @year)

        expect(page).to have_current_path(dashboard_path(year: @year))
        expect(page).to have_content(I18n.t('charts.plant_chart.header', chart_name: I18n.t(:charts)[:plant_chart][:default_name], year: @year))
        expect(page).to have_content(I18n.t('charts.department_chart.header', department: @department.abbreviation, chart_name: I18n.t(:charts)[:department_chart][:default_name], year: @year))
      end
    end
  end

  it 'should redirect to the Dashboard for the new year' do
    @year       = Time.now.year
    @department = FactoryBot.create(:department, abbreviation: 'Departed')
                  FactoryBot.create(:chart, name: 'Uncharted', year: @year)
                  FactoryBot.create(:chart, department: @department, name: 'Chartmander', year: @year)

    visit dashboard_path

    find('#yearSelectButton').click
    find('a.dropdown-item', text: @year + 1).click
    wait_for_ajax

    click_link I18n.t('charts.new_year.start_button', year: @year + 1)

    expect(page).to have_current_path(dashboard_path(year: @year + 1))
    expect(page).to have_content(I18n.t('charts.plant_chart.header', chart_name: 'Uncharted', year: @year + 1))
    expect(page).to have_content(I18n.t('charts.department_chart.header', department: @department.abbreviation, chart_name: 'Chartmander', year: @year + 1))
  end
end
