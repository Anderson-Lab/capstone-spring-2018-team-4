require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do

	describe "GET #show" do
    before :each do
      @department = FactoryBot.create(:department)
      get :show, params: {
      	id: @department.id
      }
    end

    it { is_expected.to respond_with :ok }

    it { is_expected.to render_template :show }

    it 'should assign @department' do
      expect(assigns(:department)).to eq(@department)
    end
  end

end