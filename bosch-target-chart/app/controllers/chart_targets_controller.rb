class ChartTargetsController < ApplicationController

  before_action :authenticate_user!

  def create
    @chart    = Chart.find(params[:chart_id])
    @category = Category.find(params[:category_id])
    @target   = Target.find(params[:target_id])

    if @chart.targets.where(id: @target.id).any? || (@chart.department && @chart.department != @target.department)
      # TODO: Add Flash Error
    else
      @target.update_attribute(:category_id, @category.id)
      @chart.targets << @target
    end
  end
end
