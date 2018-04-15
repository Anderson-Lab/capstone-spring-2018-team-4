require 'rails_helper'

RSpec.describe TargetsController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe "POST #create" do
    context 'with valid inputs' do
      context 'on a numerical target' do
        before :each do
          @target = FactoryBot.build(:target, :numerical)

          post :create, params: {
            target: {
              name: @target.name,
              department_id: @target.department_id,
              category_id: @target.category_id,
              unit: @target.unit,
              unit_type: @target.unit_type,
              rule: @target.rule,
              compare_to_value: @target.compare_to_value,
              comments: @target.comments,
              year: @target.year
            }
          }, format: :js
        end

        it { is_expected.to respond_with :ok }

        it { is_expected.to render_template :create }

        it 'should assign @year' do
          expect(assigns(:year)).to eq(@target.year)
        end

        it 'should save the target' do
          expect(Target.count).to eq(1)
        end
      end

      context 'on a qualitative target' do
        before :each do
          @target = FactoryBot.build(:target, :qualitative)

          post :create, params: {
            target: {
              name: @target.name,
              department_id: @target.department_id,
              category_id: @target.category_id,
              unit: @target.unit,
              unit_type: @target.unit_type,
              rule: @target.rule,
              compare_to_value: @target.compare_to_value,
              comments: @target.comments,
              year: @target.year
            }
          }, format: :js
        end

        it { is_expected.to respond_with :ok }

        it { is_expected.to render_template :create }

        it 'should assign @year' do
          expect(assigns(:year)).to eq(@target.year)
        end

        it 'should save the target' do
          expect(Target.count).to eq(1)
        end
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
            rule: nil,
            compare_to_value: nil,
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
