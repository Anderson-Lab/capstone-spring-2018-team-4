require 'rails_helper'

RSpec.describe ChartsController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe "GET #index" do
    before :each do
      @year         = Time.now.year
      @plant_chart  = FactoryBot.create(:chart)
      @department   = FactoryBot.create(:department)
      @dept_chart   = FactoryBot.create(:chart, department: @department)

      get :index, params: { year: @year }
    end

    it { is_expected.to respond_with :ok }

    it { is_expected.to render_template :index }

    it 'should assign @year' do
      expect(assigns(:year)).to eq(@year)
    end

    it 'should assign @plant_chart' do
      expect(assigns(:plant_chart)).to eq(@plant_chart)
    end

    it 'should assign @dept_charts' do
      expect(assigns(:dept_charts).length).to eq(1)
      expect(assigns(:dept_charts).first).to eq(@dept_chart)
    end
  end
end
