class DepartmentsController < ApplicationController

  before_action :authenticate_user!

  def show
    @department = Department.find(params[:id])
    @year       = get_year
    @chart      = @department.charts.find_by_year(@year)
  end

  def new
    @department = Department.new
  end

  def create
    department = Department.new(department_params)

    if department.save
      #TODO: Add flash message
    else
      @errors = department.errors
    end
  end

  def edit
    @department = Department.find(params[:id])
    @year       = get_year
  end

  def update
    @department = Department.find(params[:id])
    @year       = get_year
    @chart      = @department.charts.find_by_year(@year)

    if @department.update_attributes(department_params)
      #TODO: Add flash message
    else
      @errors = department.errors
    end
  end

  private

  def department_params
    params.require(:department).permit(
        :name,
        :abbreviation
      )
  end
end
