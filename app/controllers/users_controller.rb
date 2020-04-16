class UsersController < ApplicationController
  def index
    redirect_to signup_path
  end

  def new
    @user = User.new
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

  def upload_image
    flash.notice = 'Picture upload will be available soon.'
    redirect_to signup_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
