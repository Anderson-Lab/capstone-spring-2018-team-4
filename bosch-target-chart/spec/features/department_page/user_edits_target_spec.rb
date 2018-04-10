require 'rails_helper'

RSpec.describe "User edits a target", js: true do

  let!(:current_user) { FactoryBot.create(:user) }

  before :each do
    current_user.confirm
    sign_in(current_user)

    @department = FactoryBot.create(:department)
    @chart      = FactoryBot.create(:chart, department: @department)
    @target     = FactoryBot.create(:target, department: @department,
                    name: 'target acquired', unit: 'hours',
                    compare_to_value: 100, unit_type: Target::UNIT_TYPES[0],
                    rule: Target::RULES[0])
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

    context 'when the target is on department\'s chart' do
      it 'should update the target name' do
        @chart.targets << @target

        visit department_path(@department)

        first("a.target-name").click
        fill_in 'target_name', with: 'Targetted'
        click_button I18n.t(:actions)[:submit]
        wait_for_ajax

        expect(page).to have_selector('.chart-target .card-title', text: @target.reload.name)
      end
    end
  end

  context 'category' do
    it 'should update category' do
      @category = FactoryBot.create(:category, :no_icon)

      visit department_path(@department)

      first("a.target-category").click
      select @category.name, from: 'target_category_id'
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax

      expect(@target.reload.category).to eq(@category)
    end

    context 'when the target is on department\'s chart' do
      it 'should update the target category' do
        @category = FactoryBot.create(:category, :no_icon)
        @chart.targets << @target

        visit department_path(@department)

        first("a.target-category").click
        select @category.name, from: 'target_category_id'
        click_button I18n.t(:actions)[:submit]
        wait_for_ajax

        expect(page).to have_selector(".category-row.category-#{@category.id} .chart-target .card-title", text: @target.name)
      end
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
      select Target::UNIT_TYPES[1], from: 'target_unit_type'
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax

      expect(@target.reload.unit_type).to eq(Target::UNIT_TYPES[1])
    end

    it 'should reset indicators' do
      indicator = FactoryBot.create(:indicator, target: @target)

      visit department_path(@department)

      execute_script("$('.d-none').removeClass('d-none')")

      first("a.target-unit").click
      select Target::UNIT_TYPES[1], from: 'target_unit_type'
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax

      first('.indicator').click

      expect(page).to have_selector('.popover select#indicator_color')
    end

    context 'when the target is on department\'s chart' do
      it 'should update the target category' do
        indicator = FactoryBot.create(:indicator, target: @target, value: 200, color: nil)
        @chart.targets << @target

        visit department_path(@department)

        execute_script("$('.d-none').removeClass('d-none')")

        first("a.target-unit").click
        select Target::UNIT_TYPES[1], from: 'target_unit_type'
        click_button I18n.t(:actions)[:submit]
        wait_for_ajax

        expect(page).to have_selector(".chart-target .indicator.negative-indicator")
      end
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

    it 'should update rule' do
      visit department_path(@department)

      execute_script("$('.d-none').removeClass('d-none')")

      first("a.target-compare-to-value").click
      select Target::RULES[1], from: 'target_rule'
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax

      expect(@target.reload.rule).to eq(Target::RULES[1])
    end

    it 'should update indicators' do
      indicator = FactoryBot.create(:indicator, target: @target, value: 20)
      
      visit department_path(@department)

      execute_script("$('.d-none').removeClass('d-none')")

      first("a.target-compare-to-value").click
      fill_in 'target_compare_to_value', with: '5'
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax

      expect(page).to have_selector('.indicator.positive-indicator')
    end

    context 'when the target is on department\'s chart' do
      it 'should update the target category' do
        indicator = FactoryBot.create(:indicator, target: @target, value: 20, color: nil)
        @chart.targets << @target

        visit department_path(@department)

        execute_script("$('.d-none').removeClass('d-none')")

        first("a.target-compare-to-value").click
        fill_in 'target_compare_to_value', with: '5'
        click_button I18n.t(:actions)[:submit]
        wait_for_ajax

        expect(page).to have_selector(".chart-target .indicator.positive-indicator")
      end
    end
  end
end
