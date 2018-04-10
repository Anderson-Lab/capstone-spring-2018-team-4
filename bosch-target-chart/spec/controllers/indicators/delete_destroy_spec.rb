require 'rails_helper'

RSpec.describe IndicatorsController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe "DELETE #destroy" do
    before :each do
      @department = FactoryBot.create(:department)
      @chart      = FactoryBot.create(:chart, department: @department)
      @target     = FactoryBot.create(:target, department: @department)
      @indicator  = FactoryBot.create(:indicator, target: @target)

      delete :destroy, params: { id: @indicator.id }, format: :js
    end

    it 'should assign @indicator to the indicator' do
      expect(assigns(:indicator)).to eq(@indicator)
    end

    it 'should assign @target to the target' do
      expect(assigns(:target)).to eq(@indicator.target)
    end

    it 'should assign @chart to the correct chart' do
      expect(assigns(:chart)).to eq(@chart)
    end
      
    it 'should destroy the target' do
      expect(Indicator.count).to eq(0)
    end

    it { is_expected.to respond_with(:ok) }

    it { is_expected.to render_template(:destroy) }
  end
end
