class SessionsController < ApplicationController
  def index
    redirect_to login_url
  end

  def new; end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
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
