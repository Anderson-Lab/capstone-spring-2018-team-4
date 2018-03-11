require 'rails_helper'

RSpec.describe TargetsController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe "GET #create" do
    context 'with valid inputs' do
      before :each do
        target = FactoryBot.build(:target)
        post :create, params: {
          target: {
            name: target.name,
            department_id: target.department_id,
            category_id: target.category_id,
            unit: target.unit,
            unit_type: target.unit_type,
            comments: target.comments,
            year: target.year
          }
        }, format: :js
      end

      it { is_expected.to respond_with :ok }

      it { is_expected.to render_template :create }

      it 'should save the target' do
        expect(Target.count).to eq(1)
      end
    end

    context 'with invalid inputs' do
      before :each do
        post :create, params: {
          target: {
            name: nil,
            department_id: nil,
            category_id: nil,
            unit: nil,
            unit_type: nil,
            comments: nil,
            year: nil
          }
        }, format: :js
      end

      it { is_expected.to respond_with :ok }

      it { is_expected.to render_template :create }

      it 'should not save the target' do
        expect(Target.count).to eq(0)
      end

      it 'should assign @errors' do
        expect(:errors).to_not be_nil
      end
    end
  end
end
