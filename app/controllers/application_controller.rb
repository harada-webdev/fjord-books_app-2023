# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    %i[sign_up account_update].each { |action| devise_parameter_sanitizer.permit(action, keys: %i[name address postal_code bio]) }
  end

  private

  def after_sign_in_path_for(_resource)
    books_path
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end
end
