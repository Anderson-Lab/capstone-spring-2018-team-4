class DepartmentsController < ApplicationController
  def edit
  end

  def update
  end

  def new
  end

  def create
  end

  def show
  end

  def index
  end

  def destroy
  end

  private

  def department_params
    params.require(:department).permit(:name)
  end
end
