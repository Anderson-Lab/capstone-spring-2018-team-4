class DepartmentsController < ApplicationController

  before_action :authenticate_user!

  def index 
	 @departments = Department.all
  end 
  
  def show 
	 @department = Department.find(params[:id])
  end
end
