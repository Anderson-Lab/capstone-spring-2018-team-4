require 'rails_helper'

RSpec.describe Department, type: :model do
  it { is_expected.to have_many(:targets) }
  it { is_expected.to have_many(:charts) }

  it { is_expected.to validate_presence_of(:name) }
  it { should accept_nested_attributes_for(:charts) }

  context 'build_charts with valid parameters' do
    context 'The next year has no charts' do
      before :each do
        @current_year      = 2018
        @department        = FactoryBot.create(:department)
        @plant_chart_cy    = FactoryBot.create(:chart, department: nil, year: @current_year)
      end

      it 'should only make one department chart' do
        @department.build_charts('department chart', @current_year)
        expect(@department.charts.count).to eq(1)
      end

      it 'should make a chart for the current year only' do
        @department.build_charts('department chart', @current_year)
        expect(@department.charts.where(year: @current_year).count).to eq(@department.charts.count)
      end

      it 'should return true' do
        expect(@department.build_charts('department chart', @current_year)).to eq(true)
      end
    end

    context 'The next year has charts' do
      before :each do
        @current_year      = 2018
        @department        = FactoryBot.create(:department)
        @plant_chart_cy    = FactoryBot.create(:chart, department: nil, year: @current_year)
        @plant_chart_ny    = FactoryBot.create(:chart, department: nil, year: @current_year+1)
      end

      it 'should make two department charts' do
        @department.build_charts('department chart', @current_year)
        expect(@department.charts.count).to eq(2)
      end

      it 'should make a chart for the current year and next year' do
        @department.build_charts('department chart', @current_year)
        expect(@department.charts.where(year: @current_year).count).to eq(1)
        expect(@department.charts.where(year: @current_year+1).count).to eq(1)
      end

      it 'should return true' do
        expect(@department.build_charts('department chart', @current_year)).to eq(true)
      end
    end
  end

  context 'build_charts with invalid parameters' do
    context 'name is invalid' do
      before :each do
        @chart_name        = ''
        @current_year      = 2018
        @department        = FactoryBot.create(:department)
        @plant_chart_cy    = FactoryBot.create(:chart, department: nil, year: @current_year)
        @plant_chart_ny    = FactoryBot.create(:chart, department: nil, year: @current_year+1)
      end

      it 'should not make any charts for the department' do
        @department.build_charts(@chart_name, @current_year)
        expect(@department.charts.count).to eq(0)
      end

      it 'should return false' do
        expect(@department.build_charts(@chart_name, @current_year)).to eq(false)
      end
    end
  end
end
