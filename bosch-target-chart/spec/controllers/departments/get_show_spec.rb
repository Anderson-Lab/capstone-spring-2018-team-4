require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do

  login_user(FactoryBot.create(:user))

	describe "GET #show" do
    before :each do
      @year       = Time.now.year
      @department = FactoryBot.create(:department)
      @chart      = FactoryBot.create(:chart, department: @department)

      get :show, params: {
      	id: @department.id,
        year: @year
      }
    end

    it { is_expected.to respond_with :ok }

    it { is_expected.to render_template :show }

    it 'should assign @department' do
      expect(assigns(:department)).to eq(@department)
    end

    it 'should assign @year' do
      expect(assigns(:year)).to eq(@year)
    end

    it 'should assign @chart' do
      expect(assigns(:chart)).to eq(@chart)
    end
  end
end
