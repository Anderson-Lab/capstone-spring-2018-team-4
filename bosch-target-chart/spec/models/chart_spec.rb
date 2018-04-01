require 'rails_helper'

RSpec.describe Chart, type: :model do
  it { is_expected.to belong_to(:department) }
  
  it { is_expected.to have_and_belong_to_many(:targets) }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_numericality_of(:year).only_integer }
  it { is_expected.to validate_numericality_of(:year).is_greater_than_or_equal_to(0) }

  it 'should not allow two charts with the same department to have the same year' do
    department = FactoryBot.create(:department)
    chart_1 = FactoryBot.create(:chart, department_id: department.id, year: 2018)
    chart_2 = Chart.new(name: 'chart', department_id: department.id, year: 2018)

    expect(chart_2.valid?).to eq(false)
  end

  it 'should allow two charts with the same department to have different years' do
    department = FactoryBot.create(:department)
    chart_1 = FactoryBot.create(:chart, department_id: department.id, year: 2017)
    chart_2 = Chart.new(name: 'chart', department_id: department.id, year: 2018)

    expect(chart_2.valid?).to eq(true)
  end

  describe 'scopes' do
    describe 'for_plant' do
      it 'should return charts without a department_id' do
        chart = FactoryBot.create(:chart)
        
        expect(Chart.for_plant.count).to eq(1)
        expect(Chart.for_plant.first).to eq(chart)
      end
    end

    describe 'for_departments' do
      it 'should return charts with a department' do
        chart = FactoryBot.create(:chart, department: FactoryBot.create(:department))

        expect(Chart.for_departments.count).to eq(1)
        expect(Chart.for_departments.first).to eq(chart)
      end
    end

    describe 'for_year(year)' do
      it 'should return charts for the year' do
        chart2018 = FactoryBot.create(:chart, year: 2018)
        chart2000 = FactoryBot.create(:chart, year: 2000)

        expect(Chart.for_year(2018).count).to eq(1)
        expect(Chart.for_year(2018).first).to eq(chart2018)
      end
    end
  end

  describe 'class methods' do
    describe 'years_for_select(department=nil)' do
      context 'department present' do
        it 'should return the years of the department\'s charts' do
          department = FactoryBot.create(:department)
          (-1..1).each { |n| FactoryBot.create(:chart, department: department, year: Time.now.year + n) }

          expect(Chart.years_for_select(department)).to eq((-1..1).map{ |n| Time.now.year + n })
        end
      end

      context 'department nil' do
        it 'should return charts for all years' do
          (-1..1).each { |n| FactoryBot.create(:chart, year: Time.now.year + n) }

          expect(Chart.years_for_select).to eq((-1..1).map{ |n| Time.now.year + n })
        end

        context 'no charts for this year or next year' do
          it 'should return years from all charts plus next year' do
            FactoryBot.create(:chart, year: Time.now.year - 1)

            expect(Chart.years_for_select).to eq((-1..1).map{ |n| Time.now.year + n })
          end
        end
      end
    end
  end
end
