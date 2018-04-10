require 'rails_helper'

RSpec.describe TargetsController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe "DELETE #destroy" do
    before :each do
      @department = FactoryBot.create(:department)
      @chart      = FactoryBot.create(:chart, department: @department)
      @target     = FactoryBot.create(:target, department: @department)

      delete :destroy, params: { id: @target.id }, format: :js
    end

    it 'should assign @target to the target' do
      expect(assigns(:target)).to eq(@target)
    end

    it 'should assign @chart to the correct chart' do
      expect(assigns(:chart)).to eq(@chart)
    end
      
    it 'should assign @department' do
      expect(assigns(:department)).to eq(@target.department)
    end

    it 'should assign @year' do
      expect(assigns(:year)).to eq(@target.year)
    end

    it 'should destroy the target' do
      expect(Target.count).to eq(0)
    end

    it { is_expected.to respond_with(:ok) }

    it { is_expected.to render_template(:destroy) }
  end
end
