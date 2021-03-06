require 'rails_helper'

RSpec.describe TargetsController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe "PUT #update" do
    before :each do
      @department = FactoryBot.create(:department)
      @chart      = FactoryBot.create(:chart, department: @department)
      @target     = FactoryBot.create(:target, department: @department)
    end

    context 'target is valid' do
      before :each do
        put :update, params: {
          id: @target.id,
          target: { name: 'test name'}
        }, format: :js
      end

      it 'should assign @target to the target' do
        expect(assigns(:target)).to eq(@target)
      end

      it 'should assign @chart to the correct chart' do
        expect(assigns(:chart)).to eq(@chart)
      end

      it 'should update the attribute' do
        expect(@target.reload.name).to eq('test name')
      end

      it 'should assign @attribute' do
        expect(assigns(:attribute)).to eq('name')
      end

      it 'should assign @value' do
        expect(assigns(:value)).to eq('test name')
      end

      it { is_expected.to respond_with(:ok) }

      it { is_expected.to render_template(:update) }
    end

    context 'target is invalid' do
      before :each do
        put :update, params: {
          id: @target.id,
          target: { name: ''}
        }, format: :js
      end

      it 'should assign @target to the target' do
        expect(assigns(:target)).to eq(@target)
      end

      it 'should assign @chart to the correct chart' do
        expect(assigns(:chart)).to eq(@chart)
      end
      
      it 'should not update the target' do
        name = @target.name
        expect(@target.reload.name).to eq(name)
      end

      it 'should assign @errors' do
        expect(assigns(:errors)).to be
      end

      it { is_expected.to respond_with(:ok) }

      it { is_expected.to render_template(:update) }
    end
  end
end
