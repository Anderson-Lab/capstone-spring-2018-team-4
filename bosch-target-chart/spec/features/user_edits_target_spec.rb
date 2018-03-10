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
                    unit: 'hours', update_frequency: I18n.t(:targets)[:fields][:update_frequency][:monthly])
  end

  it 'should update name' do
    visit department_path(@department)
    
    find("a[data-original-title='#{I18n.t(:targets)[:fields][:name]}']").click
    fill_in 'target_name', with: 'Targetted'
    find('button[type=submit]').click
    wait_for_ajax
    
    expect(@target.reload.name).to eq('Targetted')
  end

  it 'should update category' do
    @category = FactoryBot.create(:category)

    visit department_path(@department)

    find("a[data-original-title='#{I18n.t(:targets)[:fields][:category]}']").click
    select @category.name, from: 'target_category_id'
    find('button[type=submit]').click
    wait_for_ajax

    expect(@target.reload.category).to eq(@category)
  end

  it 'should update unit' do
    visit department_path(@department)

    execute_script("$('.d-none').removeClass('d-none')")

    find("a[data-original-title='#{I18n.t(:targets)[:fields][:unit]}']").click
    fill_in 'target_unit', with: 'EuroDollars'
    find('button[type=submit]').click
    wait_for_ajax

    expect(@target.reload.unit).to eq('EuroDollars')
  end

  it 'should update update frequency' do
    visit department_path(@department)

    execute_script("$('.d-none').removeClass('d-none')")
    
    find("a[data-original-title='#{I18n.t(:targets)[:fields][:update_frequency][:field]}']").click
    frequency = I18n.t(:targets)[:fields][:update_frequency][:monthly]
    select frequency, from: 'target_update_frequency'
    find('button[type=submit]').click
    wait_for_ajax

    expect(@target.reload.update_frequency).to eq(frequency)
  end
end
