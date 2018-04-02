class IndicatorsController < ApplicationController
  
  before_action :authenticate_user!

  def create
    @target     = Target.find(params[:target_id])
    @indicator  = @target.indicators.new(indicator_params)

    unless @indicator.save
      @errors = @indicator.errors
    end
  end

  def update
    @indicator = Indicator.find(params[:id])

    unless @indicator.update_attributes(indicator_params)
      @errors = @indicator.errors
    end
  end

  def destroy
    @indicator  = Indicator.find(params[:id])
    @target     = @indicator.target

    @indicator.destroy
  end

  def indicator_params
    params.require(:indicator).permit(
      :name,
      :value,
      :color
    )
  end
end
