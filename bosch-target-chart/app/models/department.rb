class Department < ApplicationRecord
  has_many :targets
  has_many :charts

  accepts_nested_attributes_for :charts

  validates_presence_of :name

  def build_charts(name, year)
    chart_current_year = self.charts.new(name: name, year: year)
    chart_next_year    = self.charts.new(name: name, year: year+1) if Chart.for_year(year+1).any?

    if chart_current_year.save && save_chart(chart_next_year)
      return true
    else
      self.errors.add(:base, I18n.t(:charts)[:errors][:name])
      return false
    end
  end

  private

  def save_chart(chart)
    if chart
      return chart.save
    else
      return true
    end
  end
end
