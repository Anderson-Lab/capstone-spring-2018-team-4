require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe 'GET #edit' do
    before :each do
      @category = FactoryBot.create(:category)
      get :edit, params: {
        id: @category.id
      }, format: :js, xhr: true
    end

    it { is_expected.to respond_with :ok }

    it { is_expected.to render_template :edit }

    it 'should assign @category' do
      expect(assigns(:category)).to eq(@category)
    end
  end
end