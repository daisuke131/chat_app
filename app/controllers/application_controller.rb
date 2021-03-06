# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name]) # 新登録用
    devise_parameter_sanitizer.permit(:account_update, keys: %i[user_name user_image]) # 編集用
  end
end
