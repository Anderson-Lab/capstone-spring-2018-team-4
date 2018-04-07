require 'rails_helper'

RSpec.describe IndicatorsController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe "PUT #update" do
    before :each do
      @department = FactoryBot.create(:department)
      @chart      = FactoryBot.create(:chart, department: @department)
      @target     = FactoryBot.create(:target, department: @department)
      @indicator  = FactoryBot.create(:indicator, target: @target)
    end

    context 'indicator is valid' do
      before :each do
        put :update, params: {
          id: @indicator.id,
          indicator: { name: 'test name' }
        }, format: :js
      end

      it 'should assign @indicator to the indicator' do
        expect(assigns(:indicator)).to eq(@indicator)
      end

      it 'should assign @target to the target' do
        expect(assigns(:target)).to eq(@target)
      end

      it 'should assign @chart to the correct chart' do
        expect(assigns(:chart)).to eq(@chart)
      end

      it 'should update the attribute' do
        expect(@indicator.reload.name).to eq('test name')
      end

      it { is_expected.to respond_with(:ok) }

      it { is_expected.to render_template(:update) }
    end

    context 'indicator is invalid' do
      before :each do
        put :update, params: {
          id: @indicator.id,
          indicator: { name: nil }
        }, format: :js
      end

      it 'should assign @indicator to the indicator' do
        expect(assigns(:indicator)).to eq(@indicator)
      end

      it 'should assign @target to the target' do
        expect(assigns(:target)).to eq(@target)
      end

      it 'should assign @chart to the correct chart' do
        expect(assigns(:chart)).to eq(@chart)
      end
      
      it 'should not update the indicator' do
        name = @indicator.name
        expect(@indicator.reload.name).to eq(name)
      end

      it 'should assign @errors' do
        expect(assigns(:errors)).to be
      end

      it { is_expected.to respond_with(:ok) }

      it { is_expected.to render_template(:update) }
    end
  end
end
