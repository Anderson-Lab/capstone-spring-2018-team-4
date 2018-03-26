class TargetsController < ApplicationController

  before_action :authenticate_user!

  def new
    @department = Department.find(params[:department_id])
    @year       = get_year
    @target     = @department.targets.new 
  end

  def create
    target  = Target.new(target_params)
    @year   = target.year

    if target.save
      #TODO: Add flash message
      @department = target.department
    else
      @errors = target.errors
    end
  end

  def update
    @target = Target.find(params[:id])
    
    if @target.update_attributes(target_params)
      assign_attribute_and_value
    else
      @errors = @target.errors
    end
  end

  def destroy
    @target     = Target.find(params[:id])
    @department = @target.department
    @year       = @target.year

    @target.destroy
    #TODO: Add flash message
  end

  private

  def assign_attribute_and_value
    @attribute = target_params.keys.first.gsub('_id', '')
    
    if @attribute == 'category'
      @value = Category.find(target_params.values.first).name
    else
      @value = Float(target_params.values.first) rescue target_params.values.first
    end
  end

  def target_params
    params.require(:target).permit(
        :name,
        :department_id,
        :category_id,
        :unit,
        :unit_type,
        :compare_to_value,
        :rule,
        :comments,
        :year
      )
  end
end
