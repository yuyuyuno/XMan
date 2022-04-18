class ApplicationController < ActionController::Base
  include SessionHelper

  before_action :require_login

  around_action :switch_locale


  private

  def require_login
    unless signed_in?
      flash[:danger] = 'Требуется логин'
      redirect_to session_login_url
    end
  end
end

def switch_locale(&action)
  locale = cookies[:locale] || I18n.default_locale
  I18n.with_locale(locale, &action)
end


