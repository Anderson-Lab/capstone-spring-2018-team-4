require 'rails_helper'

RSpec.describe "User edits an indicator", js: true do

  let!(:current_user) { FactoryBot.create(:user) }

  before :each do
    current_user.confirm
    sign_in(current_user)

    @department = FactoryBot.create(:department)
    @chart      = FactoryBot.create(:chart, department: @department)
  end

  context 'for a Numerical target' do
    before :each do
      @target     = FactoryBot.create(:target, :numerical, department: @department, compare_to_value: 50)
      @indicator  = FactoryBot.create(:indicator, target: @target, value: 0)

      visit department_path(@department)
    end

    it 'should update the value' do
      first('.indicator').click
      fill_in 'indicator_value', with: 51
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax

      expect(@indicator.reload.value).to eq(51)
    end
  end

  context 'for a Qualitative target' do
    before :each do
      @target     = FactoryBot.create(:target, department: @department)
      @indicator  = FactoryBot.create(:indicator, target: @target, color: Indicator::COLORS[0])

      visit department_path(@department)
    end

    it 'should update the color' do
      first('.indicator').click
      select Indicator::COLORS[1], from: 'indicator_color'
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax

      expect(@indicator.reload.color).to eq(Indicator::COLORS[1])
    end
  end

  context 'when the target is on department\'s chart' do
    before :each do
      @target     = FactoryBot.create(:target, department: @department)
      @indicator  = FactoryBot.create(:indicator, target: @target, color: Indicator::COLORS[0])

      @chart.targets << @target

      visit department_path(@department)
    end

    it 'should update the target\'s indicator' do
      first("#target#{@target.id}Indicators .indicator").click
      select Indicator::COLORS[1], from: 'indicator_color'
      click_button I18n.t(:actions)[:submit]
      wait_for_ajax

      expect(page).to have_selector(".chart-target.target-#{@target.id} .indicator.neutral-indicator")
    end
  end
end
