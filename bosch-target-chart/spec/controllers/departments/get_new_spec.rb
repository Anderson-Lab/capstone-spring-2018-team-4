require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe "GET #new" do
    before :each do
      @current_year = 2018
      get :new, params: {
        year: @current_year
      }, format: :js, xhr: true
    end

    it { is_expected.to respond_with :ok }

    it { is_expected.to render_template :new }

    it 'should assign @department' do
      expect(assigns(:department)).to be_a(Department)
      expect(assigns(:department).new_record?).to eq(true)
    end

    it 'should assign @year' do
      expect(assigns(:year)).to eq(@current_year)
    end

    it 'should assign @chart' do
      expect(assigns(:chart)).to be_a(Chart)
      expect(assigns(:chart).new_record?).to eq(true)
    end
  end

end