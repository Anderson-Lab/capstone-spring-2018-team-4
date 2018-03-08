require 'rails_helper'

RSpec.describe TargetsController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe "GET #new" do
    before :each do
      get :new
    end

    it { is_expected.to respond_with :ok }

    it { is_expected.to render_template :new }

    it 'should assign @target' do
      expect(assigns(:target)).to be_a(Target)
      expect(assigns(:target).new_record?).to eq(true)
    end

    it "should assign @departments" do
      FactoryBot.create(:department)
      expect(assigns(:departments)).to eq(Department.all)
    end

    it "should assign @categories" do
      FactoryBot.create(:category)
      expect(assigns(:categories)).to eq(Category.all)
    end
  end

end
