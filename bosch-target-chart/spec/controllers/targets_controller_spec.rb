require 'rails_helper'

RSpec.describe TargetsController, type: :controller do

  describe "GET #new" do
    it "should assign @departments" do
      FactoryBot.create(:department)
      get :new
      expect(assigns(:departments)).to eq(Department.all)
    end

    it "should assign @categories" do
      FactoryBot.create(:category)
      get :new
      expect(assigns(:categories)).to eq(Category.all)
    end
  end

  describe "GET #create" do
  end

end
