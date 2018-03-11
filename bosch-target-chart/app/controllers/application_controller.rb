class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def get_year
    if params[:year] && Chart.years_for_select(@department).include?(params[:year].to_i)
      params[:year].to_i
    else
      Time.now.year
    end
  end
end
