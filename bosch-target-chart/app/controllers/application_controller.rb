class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :store_user_location!, if: :storable_location?
  before_action :set_locale

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || super 
  end

  def set_locale
    locale      = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end

  def get_year
    if params[:year] && Chart.years_for_select(@department).include?(params[:year].to_i)
      params[:year].to_i
    else
      Time.now.year
    end
  end

  private 

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
