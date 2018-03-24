class IndicatorsController < ApplicationController
  
  before_action :authenticate_user!

  def update
    @indicator = Indicator.find(params[:id])

    unless @indicator.update_attributes(indicator_params)
      @errors = @indicator.errors
    end
  end

  def indicator_params
    params.require(:indicator).permit(
      :name,
      :value,
      :color
    )
  end
end
