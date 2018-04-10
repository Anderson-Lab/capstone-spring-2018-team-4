require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe 'GET #new' do
    before :each do
      get :new, format: :js, xhr: true
    end

    it { is_expected.to respond_with :ok }

    it { is_expected.to render_template :new }

    it 'should assign @category' do
      expect(assigns(:category)).to be
    end
  end
end