class TargetsController < ApplicationController
  def new
    @target = Target.new
    @departments = Department.all
    @categories  = Category.all
  end

  def create
    target = Target.new(target_params)

    if target.save
      #TODO: Add flash message
    else
      @errors = target.errors
    end
  end

  private

  def target_params
    params.require(:target).permit(
        :name,
        :department_id,
        :category_id,
        :unit,
        :unit_type,
        :update_frequency,
        :comments,
        :year
      )
  end
end
