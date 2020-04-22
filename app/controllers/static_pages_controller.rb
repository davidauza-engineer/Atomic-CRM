class StaticPagesController < ApplicationController
  def home
    redirect_to profile_url if logged_in?
  end
end
