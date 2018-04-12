require 'rails_helper'

RSpec.describe ChartTargetsController, type: :controller do

  login_user(FactoryBot.create(:user))

  before :each do
    @chart      = FactoryBot.create(:chart)
    @department = FactoryBot.create(:department)
    @target     = FactoryBot.create(:target, department: @department)
                  FactoryBot.create(:indicator, target: @target)

    @chart.targets << @target

    delete :destroy, params: {
      target_id: @target.id,
      chart_id: @chart.id
    }, format: :js
  end

  describe "DELETE #destroy" do
    it 'should assign @chart' do
      expect(assigns(:chart)).to eq(@chart)
    end

    it 'should assign @target' do
      expect(assigns(:target)).to eq(@target)
    end

    it 'should remove the target from the chart' do
      expect(@chart.reload.targets.include?(@target)).to eq(false)
    end

    it { is_expected.to respond_with(:ok) }

    it { is_expected.to render_template(:destroy) }
  end
end
