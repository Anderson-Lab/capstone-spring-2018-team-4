require 'rails_helper'

RSpec.describe "User deletes an indicator", js: true do

  let!(:current_user) { FactoryBot.create(:user) }

  before :each do
    current_user.confirm
    sign_in(current_user)

    @department = FactoryBot.create(:department)
    @chart      = FactoryBot.create(:chart, department: @department)
    @target     = FactoryBot.create(:target, department: @department)
    @indicator  = FactoryBot.create(:indicator, target: @target)
  end

  it 'should delete the target' do
    visit department_path(id: @department.id)

    first('.indicator').click
    find('.delete-indicator-button').click
    find('.sweet-alert.visible button.confirm').trigger('click')
    wait_for_ajax

    expect(page).to_not have_selector('.indicator:not(.new-indicator)')
    expect(Indicator.count).to eq(0)
  end

  context 'when the target is on department\'s chart' do
    before :each do
      @chart.targets << @target

      visit department_path(id: @department.id)
    end

    it 'should update the target\'s indicators' do
      first("#target#{@target.id}Indicators .indicator").click
      find('.delete-indicator-button').click
      find('.sweet-alert.visible button.confirm').trigger('click')
      wait_for_ajax

      expect(page).to_not have_selector(".chart-target.target-#{@target.id} .indicator")
    end
  end
end
