class UsersController < ApplicationController
  before_action :authorize, only: :profile

  def index
    redirect_to signup_url
  end

  def new
    if logged_in?
      flash.notice = 'Please log out to create a new user.'
      redirect_to root_url
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in_user(@user)
      redirect_to root_url, notice: 'Thank you for signing up!'
    else
      render 'new'
    end
  end

  def upload_picture
    flash.notice = 'Picture upload will be available soon.'
    redirect_to signup_url
  end

  def profile
    @user = User.find(session[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
