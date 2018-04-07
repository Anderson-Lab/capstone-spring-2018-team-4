class ChartTargetsController < ApplicationController

  before_action :authenticate_user!

  def create
    @chart    = Chart.find(params[:chart_id])
    @target   = Target.find(params[:target_id])

    if @chart.targets.where(id: @target.id).any? || (@chart.department && @chart.department != @target.department)
      # TODO: Add Flash Error
    else
      @chart.targets << @target
    end
  end
end
   