class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale

  def set_locale
    locale = if
                current_user
                current_user.settings.locale
             elsif params[:locale]
                session[:locale] = params[:locale]
             elsif session[:locale]
               session[:locale]
             else
                http_accept_language.compatible_language_from(I18n.available_locales)
             end
    #TODO отключить принудительную локацию
    locale = 'ru'
    puts "___________________#{locale}_________________"
  if locale && I18n.available_locales.include?(locale.to_sym)
    session[:locale] = I18n.locale = locale.to_sym
  end

  end
end
