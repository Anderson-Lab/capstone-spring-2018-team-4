require 'rails_helper'

RSpec.describe Chart, type: :model do
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
end
