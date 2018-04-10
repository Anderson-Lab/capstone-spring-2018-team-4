class CategoriesController < ApplicationController
  
  before_action :authenticate_user!

  def index
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new(category_params)

    if category.save
      #TODO: Add flash message
    else
      @errors = category.errors
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    category = Category.find(params[:id])

    if category.update_attributes(category_params)
      #TODO: Add flash message
    else
      @errors = category.errors
    end
  end

  private

  def category_params
    params.require(:category).permit(
        :name,
        :color,
        :icon
      )
  end
end
