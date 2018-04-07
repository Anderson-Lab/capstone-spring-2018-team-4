class IndicatorsController < ApplicationController
  
  before_action :authenticate_user!

  def create
    @target     = Target.find(params[:target_id])
    @indicator  = @target.indicators.new(indicator_params)
    @chart      = @target.department.charts.for_year(@target.year).first

    unless @indicator.save
      @errors = @indicator.errors
    end
  end

  def update
    @indicator  = Indicator.find(params[:id])
    @target     = @indicator.target
    @chart      = @target.department.charts.for_year(@target.year).first

    unless @indicator.update_attributes(indicator_params)
      @errors = @indicator.errors
    end
  end

  def destroy
    @indicator  = Indicator.find(params[:id])
    @target     = @indicator.target
    @chart      = @target.department.charts.for_year(@target.year).first

    @indicator.destroy
  end

  private

  def indicator_params
    params.require(:indicator).permit(
      :name,
      :value,
      :color
    )
  end
end
