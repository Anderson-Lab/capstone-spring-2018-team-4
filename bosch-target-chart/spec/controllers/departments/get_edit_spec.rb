require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe "GET #edit" do
    before :each do
      @department = FactoryBot.create(:department)
      @current_year = 2018
      @chart = FactoryBot.create(:chart, year: @current_year, department: @department)

      get :edit, params: {
        id: @department.id,
        year: @current_year
      }, format: :js, xhr: true
    end

    it { is_expected.to respond_with :ok }

    it { is_expected.to render_template :edit }

    it 'should assign @department' do
      expect(assigns(:department)).to eq(@department)
    end

    it 'should assign @year' do
      expect(assigns(:year)).to eq(@current_year)
    end

    it 'should assign @chart' do
      expect(assigns(:chart)).to eq(@chart)
    end
  end

end