require 'rails_helper'

RSpec.describe "User edits a target", js: true do

  let!(:current_user) { FactoryBot.create(:user) }

  before :each do
    current_user.confirm
    sign_in(current_user)

    @department = FactoryBot.create(:department)
                  FactoryBot.create(:chart, department: @department)
    @target     = FactoryBot.create(:target, :numerical, department: @department,
                    category: FactoryBot.create(:category), name: 'target acquired',
                    unit: 'hours', compare_to_value: 100,
                    rule: I18n.t(:targets)[:fields][:rule][:greater_than_or_equal])
                    unit_type: Target::UNIT_TYPES[1])
  end

  context 'name' do
    it 'should update name' do
      visit department_path(@department)
      
      first("a.target-name").click
      fill_in 'target_name', with: 'Targetted'
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax
      
      expect(@target.reload.name).to eq('Targetted')
    end
  end

  context 'category' do
    it 'should update category' do
      @category = FactoryBot.create(:category)

      visit department_path(@department)

      first("a.target-category").click
      select @category.name, from: 'target_category_id'
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax

      expect(@target.reload.category).to eq(@category)
    end
  end

  context 'unit and unit type' do
    it 'should update unit' do
      visit department_path(@department)

      execute_script("$('.d-none').removeClass('d-none')")

      first("a.target-unit").click
      fill_in 'target_unit', with: 'EuroDollars'
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax

      expect(@target.reload.unit).to eq('EuroDollars')
    end

    it 'should update unit_type' do
      visit department_path(@department)

      execute_script("$('.d-none').removeClass('d-none')")

      first("a.target-unit").click
      select Target::UNIT_TYPES[0], from: 'target_unit_type'
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax

      expect(@target.reload.unit_type).to eq(Target::UNIT_TYPES[0])
    end

    it 'should reset indicators' do
      indicator = FactoryBot.create(:indicator, target: @target)

      visit department_path(@department)

      execute_script("$('.d-none').removeClass('d-none')")

      first("a.target-unit").click
      select Target::UNIT_TYPES[0], from: 'target_unit_type'
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax

      first('.indicator').click

      expect(page).to have_selector('.popover input#indicator_value')
    end
  end

  context 'compare_to_value' do
    it 'should update compare_to_value' do
      visit department_path(@department)

      execute_script("$('.d-none').removeClass('d-none')")

      first("a.target-compare-to-value").click
      fill_in 'target_compare_to_value', with: '5'
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax

      expect(@target.reload.compare_to_value).to eq(5)
    end
  end

  it 'should update rule' do
    visit department_path(@department)

    execute_script("$('.d-none').removeClass('d-none')")

    first("a.target-compare-to-value").click
    select I18n.t(:targets)[:fields][:rule][:less_than_or_equal], from: 'target_rule'
    click_button 'Submit'
    wait_for_ajax

    expect(@target.reload.rule).to eq(I18n.t(:targets)[:fields][:rule][:less_than_or_equal])
  end
end
