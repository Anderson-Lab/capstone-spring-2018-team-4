require 'rails_helper'

RSpec.describe "User creates an indicator", js: true do

  let!(:current_user) { FactoryBot.create(:user) }

  before :each do
    current_user.confirm
    sign_in(current_user)

    @department = FactoryBot.create(:department)
    @chart      = FactoryBot.create(:chart, department: @department)
  end

  context 'for a Numerical target' do
    before :each do
      @target = FactoryBot.create(:target, :numerical, department: @department, 
                                  compare_to_value: 50, rule: Target::RULES[0])

      visit department_path(@department)
    end

    it 'should create the indicator' do
      first('.new-indicator').click
      fill_in 'indicator_name', with: 'ASD'
      fill_in 'indicator_value', with: 10
      click_button I18n.t(:actions)[:create]
      wait_for_ajax

      expect(Indicator.count).to eq(1)
      expect(Indicator.first.name).to eq('ASD')
      expect(Indicator.first.value).to eq(10)
      expect(page).to have_selector("#target#{@target.id}Indicators .indicator.negative-indicator")
    end
  end

  context 'for a Qualitative target' do
    before :each do
      @target = FactoryBot.create(:target, department: @department)

      visit department_path(@department)
    end

    it 'should create the indicator' do
      first('.new-indicator').click
      fill_in 'indicator_name', with: 'ASD'
      select Indicator::COLORS[1], from: 'indicator_color'
      click_button I18n.t(:actions)[:create]
      wait_for_ajax

      expect(Indicator.count).to eq(1)
      expect(Indicator.first.name).to eq('ASD')
      expect(Indicator.first.color).to eq(Indicator::COLORS[1])
      expect(page).to have_selector("#target#{@target.id}Indicators .indicator.neutral-indicator")
    end
  end

  context 'when the target is on department\'s chart' do
    before :each do
      @target = FactoryBot.create(:target, department: @department)
                FactoryBot.create(:indicator, target: @target)

      @chart.targets << @target

      visit department_path(@department)
    end

    it 'should update the target with the new indicator' do
      first('.new-indicator').click
      fill_in 'indicator_name', with: 'ASD'
      select Indicator::COLORS[1], from: 'indicator_color'
      click_button I18n.t(:actions)[:create]
      wait_for_ajax

      expect(page).to have_selector(".chart-target.target-#{@target.id} .indicator", count: 2)
    end
  end
end
