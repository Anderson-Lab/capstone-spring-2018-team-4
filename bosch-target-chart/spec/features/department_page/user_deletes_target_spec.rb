require 'rails_helper'

RSpec.describe "User deletes a target", js: true do

  let!(:current_user) { FactoryBot.create(:user) }

  before :each do
    current_user.confirm
    sign_in(current_user)

    @department = FactoryBot.create(:department)
    @chart      = FactoryBot.create(:chart, department: @department)
    @target     = FactoryBot.create(:target, name: "Target Inc", department: @department)
  end

  it 'should rerender the targets table' do
    visit department_path(@department)

    execute_script("$('.d-none').removeClass('d-none')")

    find('.delete-target-button').click
    find('.sweet-alert.visible button.confirm').trigger('click')
    wait_for_ajax

    expect(page).to_not have_content(@target.name)
    expect(Target.count).to eq(0)
  end
end
