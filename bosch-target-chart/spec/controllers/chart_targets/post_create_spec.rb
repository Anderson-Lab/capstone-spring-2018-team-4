require 'rails_helper'

RSpec.describe ChartTargetsController, type: :controller do

  login_user(FactoryBot.create(:user))

  before :each do
    @pm_chart     = FactoryBot.create(:chart)
    
    @department_1 = FactoryBot.create(:department)
    @chart_1      = FactoryBot.create(:chart, department: @department_1)
    @target_1     = FactoryBot.create(:target, department: @department_1)
    @indicator_1  = FactoryBot.create(:indicator, target: @target_1)

    @department_2 = FactoryBot.create(:department)
    @chart_2      = FactoryBot.create(:chart, department: @department_2)
    @target_2     = FactoryBot.create(:target, department: @department_2)
    @indicator_2  = FactoryBot.create(:indicator, target: @target_2)
  end

  describe "POST #create" do
    context 'target added to valid chart' do
      before :each do
        post :create, params: {
          chart_id: @pm_chart.id,
          target_id: @target_1.id
        }, format: :js
      end

      it 'should assign @chart' do
        expect(assigns(:chart)).to eq(@pm_chart)
      end

      it 'should assign @target' do
        expect(assigns(:target)).to eq(@target_1 )
      end

      it 'should add the target to the chart' do
        expect(@pm_chart.reload.targets.include?(@target_1)).to eq(true)
      end

      it { is_expected.to respond_with(:ok) }

      it { is_expected.to render_template(:create) }
    end

    context 'target added to chart where already present' do
      before :each do
        @pm_chart.targets << @target_1

        post :create, params: {
          chart_id: @pm_chart.id,
          target_id: @target_1.id
        }, format: :js
      end

      it 'should assign @chart' do
        expect(assigns(:chart)).to eq(@pm_chart)
      end

      it 'should assign @target' do
        expect(assigns(:target)).to eq(@target_1 )
      end

      it 'should not add the target to the chart' do
        expect(@pm_chart.reload.targets.where(id: @target_1.id).count).to eq(1)
      end

      it { is_expected.to respond_with(:ok) }

      it { is_expected.to render_template(:create) }
    end

    context 'target added to chart for wrong department' do
      before :each do
        @pm_chart.targets << @target_1

        post :create, params: {
          chart_id: @chart_2.id,
          target_id: @target_1.id
        }, format: :js
      end

      it 'should assign @chart' do
        expect(assigns(:chart)).to eq(@chart_2)
      end

      it 'should assign @target' do
        expect(assigns(:target)).to eq(@target_1 )
      end

      it 'should not add the target to the chart' do
        expect(@chart_2.reload.targets.count).to eq(0)
      end

      it { is_expected.to respond_with(:ok) }

      it { is_expected.to render_template(:create) }
    end
  end
end
