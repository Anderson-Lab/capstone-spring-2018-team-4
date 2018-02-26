require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do

	describe "GET #index" do
    before :each do
      FactoryBot.create(:department)
      get :index
    end

    it { is_expected.to respond_with :ok }

    it { is_expected.to render_template :index }

    it 'should assign @departments' do
      expect(assigns(:departments)).to eq(Department.all)
    end
  end

end
