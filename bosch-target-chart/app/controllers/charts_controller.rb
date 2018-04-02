class ChartsController < ApplicationController

  before_action :authenticate_user!

  def index
    @year         = get_year
    @plant_chart  = Chart.for_plant.for_year(@year).first
    @dept_charts  = Chart.for_departments.for_year(@year)
  end

  def create
    @year = get_year + 1

    create_charts_for_year

    redirect_to dashboard_path(year: @year)
  end

  private

  def create_charts_for_year
    # Create the plant chart
    Chart.create(
      name: Chart.for_plant.for_year(@year - 1).first.try(:name) || t(:charts)[:plant_chart][:default_name],
      year: @year
    )

    # Create charts for all departments
    Department.all.each do |department|
      department.charts.create(
        name: department.charts.for_year(@year - 1).first.try(:name) || t(:charts)[:department_chart][:default_name],
        year: @year
      )

      clone_targets_for_year(department)
    end
  end

  def clone_targets_for_year(department)
    department.targets.for_year(@year - 1).each do |target|
      # Clone the target
      (new_target = department.targets.new(
        name: target.name,
        category: target.category,
        unit: target.unit,
        unit_type: target.unit_type,
        compare_to_value: nil,
        rule: nil,
        comments: target.comments,
        year: @year
      )).save(validate: false)

      # Clone Target's Indicators
      target.indicators.each do |indicator|
        new_target.indicators.new(
          name: indicator.name,
          value: nil,
          color: nil
        ).save(validate: false)
      end

      # Clone Target's ChartsTargets
      target.charts.each do |chart|
        new_target.charts << Chart.for_year(@year).where(department: chart.department).first
      end
    end
  end
end
