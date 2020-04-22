class ApplicationController < ActionController::Base
  def log_in_user(user)
    session[:user_id] = user.id
  end

  private

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to login_url, alert: 'Please log in to enter your profile.' if current_user.nil?
  end
end
