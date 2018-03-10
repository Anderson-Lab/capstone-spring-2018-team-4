require 'rails_helper'

RSpec.describe TargetsController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe "GET #new" do
    before :each do
      @department = FactoryBot.create(:department)
      @year = Time.now.year

      get :new, params: {
        department_id: @department.id,
        year: @year
      }, format: :js, xhr: true
    end

    it { is_expected.to respond_with :ok }

    it { is_expected.to render_template :new }

    it 'should assign @department' do
      expect(assigns(:department)).to eq (@department)
    end

    it 'should assign @year' do
      expect(assigns(:year)).to eq(@year)
    end

    it 'should assign @target' do
      expect(assigns(:target)).to be_a(Target)
      expect(assigns(:target).new_record?).to eq(true)
    end
  end
end
