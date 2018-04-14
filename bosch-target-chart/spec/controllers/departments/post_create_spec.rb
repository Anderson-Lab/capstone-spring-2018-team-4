require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe "POST #create" do
    context 'with valid parameters' do
      context 'and the next year has no charts' do
        before :each do
          @department = FactoryBot.build(:department)
          @current_year = 2018
          @plant_chart_cy = FactoryBot.create(:chart, department: nil, year: @current_year)

          post :create, params: {
            department: {
              name: @department.name,
              abbreviation: @department.abbreviation,
              charts_attributes: {
                "0" => {
                  name: 'new chart name'
                }
              }
            }
          }, format: :js, xhr: true
        end

        it { is_expected.to respond_with :ok }

        it { is_expected.to render_template :create }

        it 'should assign @chart' do
          expect(assigns(:chart)).to eq(Department.first.charts.first)
        end

        it 'should assign @year' do
          expect(assigns(:year)).to eq(@current_year)
        end

        it 'should assign @department' do
          expect(assigns(:department)).to eq(Department.first)
        end

        it 'should save the department' do
          expect(Department.count).to eq(1)
        end

        it 'should create one chart for the department' do
          expect(Department.first.charts.count).to eq(1)
        end

        it 'should create the department\'s chart for the current year' do
          expect(Department.first.charts.first.year).to eq(@current_year)
        end
      end

      context 'and the next year has charts' do
        before :each do
          @department = FactoryBot.build(:department)
          @current_year = 2018
          @plant_chart_cy = FactoryBot.create(:chart, department: nil, year: @current_year)
          @plant_chart_ny = FactoryBot.create(:chart, department: nil, year: @current_year+1)

          post :create, params: {
            department: {
              name: @department.name,
              abbreviation: @department.abbreviation,
              charts_attributes: {
                "0" => {
                  name: 'new chart name'
                }
              }
            }
          }, format: :js, xhr: true
        end

        it { is_expected.to respond_with :ok }

        it { is_expected.to render_template :create }

        it 'should assign @chart' do
          expect(assigns(:chart)).to eq(Department.first.charts.find_by_year(@current_year))
        end

        it 'should assign @year' do
          expect(assigns(:year)).to eq(@current_year)
        end

        it 'should assign @department' do
          expect(assigns(:department)).to eq(Department.first)
        end

        it 'should save the department' do
          expect(Department.count).to eq(1)
        end

        it 'should create two charts for the department' do
          expect(Department.first.charts.count).to eq(2)
        end

        it 'should create the department\'s chart for the current and next year' do
          expect(Department.first.charts.map(&:year)).to eq([@current_year, @current_year+1])
        end
      end
    end

    context 'with invalid department parameters' do
      before :each do
          @department = FactoryBot.build(:department)
          @current_year = 2018
          @plant_chart_cy = FactoryBot.create(:chart, department: nil, year: @current_year)

          post :create, params: {
            department: {
              name: '',
              abbreviation: @department.abbreviation,
              charts_attributes: {
                "0" => {
                  name: 'new chart name'
                }
              }
            }
          }, format: :js, xhr: true
      end

      it { is_expected.to respond_with :ok }

      it { is_expected.to render_template :create }

      it 'should assign @errors' do
        expect(assigns(:errors)).to be
      end

      it 'should not save the department' do
        expect(Department.count).to eq(0)
      end

      it 'should not save any new charts' do
        expect(Chart.for_departments).to be_empty
      end
    end

    context 'with invalid chart parameters' do
      before :each do
          @department = FactoryBot.build(:department)
          @current_year = 2018
          @plant_chart_cy = FactoryBot.create(:chart, department: nil, year: @current_year)

          post :create, params: {
            department: {
              name: @department.name,
              abbreviation: @department.abbreviation,
              charts_attributes: {
                "0" => {
                  name: ''
                }
              }
            }
          }, format: :js, xhr: true
      end

      it { is_expected.to respond_with :ok }

      it { is_expected.to render_template :create }

      it 'should assign @errors' do
        expect(assigns(:errors)).to be
      end

      it 'should not save the department' do
        expect(Department.count).to eq(0)
      end

      it 'should not save any new charts' do
        expect(Chart.for_departments).to be_empty
      end
    end
  end

end