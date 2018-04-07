require 'rails_helper'

RSpec.describe IndicatorsController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe "POST #create" do
    context 'indicator is valid' do
      before :each do
        @department = FactoryBot.create(:department)
        @chart      = FactoryBot.create(:chart, department: @department)
        @target     = FactoryBot.create(:target, department: @department)

        post :create, params: {
          target_id: @target.id,
          indicator: {
            name: 'test name',
            color: Indicator::COLORS[1]
          }
        }, format: :js
      end

      it 'should assign @target to the target' do
        expect(assigns(:target)).to eq(@target)
      end

      it 'should assign @chart to the correct chart' do
        expect(assigns(:chart)).to eq(@chart)
      end

      it 'should create a new indicator and assign @indicator' do
        expect(Indicator.count).to eq(1)
        expect(assigns(:indicator)).to eq(Indicator.first)
      end

      it { is_expected.to respond_with(:ok) }

      it { is_expected.to render_template(:create) }
    end

    context 'indicator is invalid' do
      before :each do
        @department = FactoryBot.create(:department)
        @chart      = FactoryBot.create(:chart, department: @department)
        @target     = FactoryBot.create(:target, department: @department)

        post :create, params: {
          target_id: @target.id,
          indicator: {
            name: nil,
            color: nil
          }
        }, format: :js
      end

      it 'should assign @target to the target' do
        expect(assigns(:target)).to eq(@target)
      end

      it 'should assign @chart to the correct chart' do
        expect(assigns(:chart)).to eq(@chart)
      end
      
      it 'should assign @indicator to a new indicator' do
        expect(assigns(:indicator)).to be_a_new(Indicator)
      end

      it 'should not save the indicator' do
        expect(Indicator.count).to eq(0)
      end

      it 'should assign @errors' do
        expect(assigns(:errors)).to be
      end

      it { is_expected.to respond_with(:ok) }

      it { is_expected.to render_template(:create) }
    end
  end
end
