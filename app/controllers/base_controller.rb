class BaseController < ApplicationController
  protect_from_forgery
  helper_method :current_user

  def login_required
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else 
      redirect_to root_path
    end

  end

  private
  def current_user
    @current_user ||= SessionUser.new(session) if session[:user_id]
  end
end
