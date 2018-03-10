class DepartmentsController < ApplicationController

  before_action :authenticate_user!

  def index 
	 @departments = Department.all
  end 
  
  def show
    @department = Department.find(params[:id])
    @year       = get_year
    @chart      = @department.charts.find_by_year(@year)
  end
end
