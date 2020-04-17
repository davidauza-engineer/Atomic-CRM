class StaticPagesController < ApplicationController
  def home
    redirect_to profile_url if current_user
  end
end
