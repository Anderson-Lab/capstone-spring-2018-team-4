require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe "PUT #update" do
    context 'valid parameters' do
      before :each do
        @department       = FactoryBot.create(:department)
        @current_year     = 2018
        @dep_chart        = FactoryBot.create(:chart, department: @department, year: @current_year)
        @new_dep_name     = 'new department name'
        @new_abbreviation = 'XYZ'
        @new_chart_name   = 'new chart name'

        put :update, params: {
          id: @department.id,
          department: {
            name: @new_dep_name,
            abbreviation: @new_abbreviation,
            charts_attributes: {
              "0" => {
                id: @dep_chart.id,
                name: @new_chart_name
              }
            }
          }
        }, format: :js, xhr: true
      end

      it { is_expected.to respond_with :ok }

      it { is_expected.to render_template :update }

      it 'should assign @chart' do
        expect(assigns(:chart)).to eq(@dep_chart)
      end

      it 'should assign @year' do
        expect(assigns(:year)).to eq(@current_year)
      end

      it 'should assign @department' do
        expect(assigns(:department)).to eq(@department)
      end

      it 'should update the department' do
        expect(@department.reload.name).to eq(@new_dep_name)
        expect(@department.reload.abbreviation).to eq(@new_abbreviation)
      end

      it 'should update the department\'s chart for the current year' do
        expect(@dep_chart.reload.name).to eq(@new_chart_name)
      end
    end

    context 'invalid department parameters' do
      before :each do
        @department       = FactoryBot.create(:department)
        @current_year     = 2018
        @dep_chart        = FactoryBot.create(:chart, department: @department, year: @current_year)

        put :update, params: {
          id: @department.id,
          department: {
            name: '',
            abbreviation: 'XYZ',
            charts_attributes: {
              "0" => {
                id: @dep_chart.id,
                name: 'new chart name'
              }
            }
          }
        }, format: :js, xhr: true
      end

      it { is_expected.to respond_with :ok }

      it { is_expected.to render_template :update }

      it 'should assign @errors' do
        expect(assigns(:errors)).to be
      end

      it 'should not update the department' do
        old_name = @department.name
        old_abbreviation = @department.abbreviation
        expect(@department.reload.name).to eq(old_name)
        expect(@department.reload.abbreviation).to eq(old_abbreviation)
      end

      it 'should not update the chart' do
        old_name = @dep_chart.name
        expect(@dep_chart.reload.name).to eq(old_name)
      end
    end

    context 'invalid chart parameters' do
      before :each do
        @department       = FactoryBot.create(:department)
        @current_year     = 2018
        @dep_chart        = FactoryBot.create(:chart, department: @department, year: @current_year)

        put :update, params: {
          id: @department.id,
          department: {
            name: 'new department name',
            abbreviation: 'XYZ',
            charts_attributes: {
              "0" => {
                id: @dep_chart.id,
                name: ''
              }
            }
          }
        }, format: :js, xhr: true
      end

      it { is_expected.to respond_with :ok }

      it { is_expected.to render_template :update }

      it 'should assign @errors' do
        expect(assigns(:errors)).to be
      end

      it 'should not update the department' do
        old_name = @department.name
        old_abbreviation = @department.abbreviation
        expect(@department.reload.name).to eq(old_name)
        expect(@department.reload.abbreviation).to eq(old_abbreviation)
      end

      it 'should not update the chart' do
        old_name = @dep_chart.name
        expect(@dep_chart.reload.name).to eq(old_name)
      end
    end
  end

end