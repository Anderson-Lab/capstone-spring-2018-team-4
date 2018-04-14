require 'rails_helper'

RSpec.describe "User removes a target from a chart", js: true do

  let!(:current_user) { FactoryBot.create(:user) }

  before :each do
    current_user.confirm
    sign_in(current_user)

    @department = FactoryBot.create(:department)
    @chart      = FactoryBot.create(:chart)
    @target     = FactoryBot.create(:target, department: @department)
                  FactoryBot.create(:indicator, target: @target)

    @chart.targets << @target

    visit dashboard_path
  end

  it 'should remove the target' do
    first('.remove-chart-target').click
    find('.sweet-alert.visible button.confirm').trigger('click')
    wait_for_ajax

    expect(@chart.reload.targets.count).to eq(0)
    expect(page).to_not have_selector('.chart-target')
  end
end
