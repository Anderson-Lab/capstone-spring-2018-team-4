require 'rails_helper'

RSpec.describe "User deletes an indicator", js: true do

  let!(:current_user) { FactoryBot.create(:user) }

  before :each do
    current_user.confirm
    sign_in(current_user)

    @department = FactoryBot.create(:department)
                  FactoryBot.create(:chart, department: @department)
    @target     = FactoryBot.create(:target, department: @department)
    @indicator  = FactoryBot.create(:indicator, target: @target)
  end

  it 'should delete the target' do
    visit department_path(@department)

    first('.indicator').click
    find('.delete-indicator-button').click
    find('.sweet-alert.visible button.confirm').trigger('click')
    wait_for_ajax

    expect(page).to_not have_selector('.indicator:not(.new-indicator)')
    expect(Indicator.count).to eq(0)
  end
end
