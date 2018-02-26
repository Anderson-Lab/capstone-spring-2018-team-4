class TargetsController < ApplicationController
  def new
    @departments = Department.all
    @categories  = Category.all
  end

  def create
  end
end
