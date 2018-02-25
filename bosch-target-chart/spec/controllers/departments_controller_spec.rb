require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do

  describe "#index" do
    it "should assign @departments" do
      FactoryBot.create(:department)
      get :index
      expect(assigns(:departments)).to eq(Department.all)
    end
  end

end
