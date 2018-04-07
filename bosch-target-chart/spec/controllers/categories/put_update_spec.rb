require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe 'PUT #update' do
    context 'category is valid' do
      before :each do
        @category = FactoryBot.create(:category)
        put :update, params: {
          id: @category.id,
          category: {
            name: 'Test Category Name'
          }
        }, format: :js
      end

      it 'should update the category' do
        expect(@category.reload.name).to eq('Test Category Name')
      end

      it { is_expected.to respond_with(:ok) }

      it { is_expected.to render_template(:update) }
    end

    context 'category is invalid' do
      before :each do
        @category = FactoryBot.create(:category)
        put :update, params: {
          id: @category.id,
          category: {
            name: ''
          }
        }, format: :js
      end

      it 'should not update the category' do
        name = @category.name
        expect(@category.reload.name).to eq(name)
      end

      it 'should assign @errors' do
        expect(assigns(:errors)).to be
      end

      it { is_expected.to respond_with(:ok) }

      it { is_expected.to render_template(:update) }
    end
  end
end