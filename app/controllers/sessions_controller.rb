class SessionsController < ApplicationController
  def index
    redirect_to login_url
  end

  def new
    return unless logged_in?

    flash.notice = 'You are already logged in.'
    redirect_to root_url
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user&.authenticate(params[:password])
      log_in_user(user)
      redirect_to root_url, notice: 'Logged in!'
    else
      flash.now.alert = 'Email or password is invalid.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end

  def reset_password
    flash.notice = 'Password reset will be available soon.'
    redirect_to login_path
  end
end
