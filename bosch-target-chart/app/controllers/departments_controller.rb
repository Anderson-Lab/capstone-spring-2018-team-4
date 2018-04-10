class DepartmentsController < ApplicationController

  before_action :authenticate_user!

  def show
    @department = Department.find(params[:id])
    @year       = get_year
    @chart      = @department.charts.find_by_year(@year)
  end

  def new
    @department = Department.new
    @year       = get_year
    @chart      = Chart.new
  end

  def create
    @department = Department.new(name: department_params[:name],
                                abbreviation: department_params[:abbreviation])
    @year       = get_year

    Department.transaction do
      if @department.save && @department.build_charts(department_params[:charts_attributes]['0'][:name], @year)
        #TODO: Add flash message
        @chart = @department.charts.find_by_year(@year)
      else
        @errors = @department.errors
        raise ActiveRecord::Rollback
      end
    end
  end

  def edit
    @department = Department.find(params[:id])
    @year       = get_year
    @chart      = @department.charts.find_by_year(@year)
  end

  def update
    @department = Department.find(params[:id])

    if @department.update_attributes(department_params)
      @year  = get_year
      @chart = @department.charts.find_by_year(@year)
      #TODO: Add flash message
    else
      @errors = department.errors
    end
  end

  private

  def department_params
    params.require(:department).permit(
        :name,
        :abbreviation,
        charts_attributes: [
          :id,
          :name
        ]
      )
  end
end
