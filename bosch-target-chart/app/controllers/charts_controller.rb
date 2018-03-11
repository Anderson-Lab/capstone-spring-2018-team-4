class ChartsController < ApplicationController

  before_action :authenticate_user!

  def index
    @year         = get_year
    @plant_chart  = Chart.for_plant.for_year(@year).first
    @dept_charts  = Chart.for_departments.for_year(@year)
  end
end
