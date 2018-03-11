require 'rails_helper'

RSpec.describe "User edits a target", js: true do

  let!(:current_user) { FactoryBot.create(:user) }

  before :each do
    current_user.confirm
    sign_in(current_user)

    @department = FactoryBot.create(:department)
                  FactoryBot.create(:chart, department: @department)
    @target     = FactoryBot.create(:target, department: @department,
                    category: FactoryBot.create(:category), name: 'target acquired',
                    unit: 'hours',
                    unit_type: I18n.t(:targets)[:fields][:unit_type][:qualitative])
  end

  it 'should update name' do
    visit department_path(@department)
    
    first("a.target-name").click
    fill_in 'target_name', with: 'Targetted'
    click_button 'Submit'
    wait_for_ajax
    
    expect(@target.reload.name).to eq('Targetted')
  end

  it 'should update category' do
    @category = FactoryBot.create(:category)

    visit department_path(@department)

    first("a.target-category").click
    select @category.name, from: 'target_category_id'
    click_button 'Submit'
    wait_for_ajax

    expect(@target.reload.category).to eq(@category)
  end

  it 'should update unit' do
    visit department_path(@department)

    execute_script("$('.d-none').removeClass('d-none')")

    first("a.target-unit").click
    fill_in 'target_unit', with: 'EuroDollars'
    click_button 'Submit'
    wait_for_ajax

    expect(@target.reload.unit).to eq('EuroDollars')
  end

  it 'should update unit_type' do
    visit department_path(@department)

    execute_script("$('.d-none').removeClass('d-none')")

    first("a.target-unit").click
    select I18n.t(:targets)[:fields][:unit_type][:numerical], from: 'target_unit_type'
    click_button 'Submit'
    wait_for_ajax

    expect(@target.reload.unit_type).to eq(I18n.t(:targets)[:fields][:unit_type][:numerical])
  end
end
