require 'rails_helper'

RSpec.describe ChartsController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe "POST #create" do
    before :each do
      @year         = Time.now.year + 1
      @department_1 = FactoryBot.create(:department)
      @department_2 = FactoryBot.create(:department)
      @chart_pm     = FactoryBot.create(:chart, year: @year - 1)
      @chart_1      = FactoryBot.create(:chart, department: @department_1, year: @year - 1)
      @target_1     = FactoryBot.create(:target, department: @department_1, year: @year - 1)
      @target_2     = FactoryBot.create(:target, department: @department_2, year: @year - 1)
      @indicator_1  = FactoryBot.create(:indicator, target: @target_1)
      @indicator_2  = FactoryBot.create(:indicator, target: @target_2)

      # Add Chart Targets
      @target_1.charts << @chart_1
      @target_2.charts << @chart_pm

      post :create, params: {}
    end

    it { is_expected.to respond_with(:redirect) }
    it { is_expected.to redirect_to(dashboard_path(year: @year)) }

    it 'should assign @year' do
      expect(assigns(:year)).to eq(@year)
    end

    it 'should create a plant chart' do
      expect(Chart.for_plant.for_year(@year).count).to eq(1)
    end

    it 'should create charts for departments' do
      expect(Chart.for_departments.for_year(@year).count).to eq(2)
      expect(Chart.for_departments.for_year(@year).pluck(:department_id)).to eq([@department_1.id, @department_2.id])
    end

    it 'should clone targets' do
      expect(Target.for_year(@year).count).to eq(2)
    end

    it 'should clone indicators' do
      expect(Indicator.where(target: Target.for_year(@year)).count).to eq(2)
    end

    it 'should clone ChartsTargets' do
      expect(Target.for_year(@year).map(&:charts).flatten.uniq.count).to eq(2)
    end
  end
end
