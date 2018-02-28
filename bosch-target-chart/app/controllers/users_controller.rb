class UsersController < ApplicationController
  
  before_action :authenticate_user!

  def show
    respond_to do |format|
      format.html
    end
  end
end
