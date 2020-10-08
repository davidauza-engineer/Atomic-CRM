require 'rails_helper'

RSpec.describe ApplicationController do
  let(:user) do
    User.create(name: 'Juan', email: 'juan@email.com', password: 'topsecret')
  end

  describe 'log_in_user method' do
    it 'returns the right user id' do
      session[:id] = controller.log_in_user(user)
      expect(session[:id]).to eq User.first.id
    end
  end

  describe 'logged_in? method' do
    it 'returns true if the user is logged in' do
      session[:user_id] = user.id
      expect(controller.send(:logged_in?)).to eq true
    end

    it 'returns false if the user is not logged in' do
      expect(controller.send(:logged_in?)).to eq false
    end
  end

  describe 'current_user method' do
    it 'returns the appropriate user if it is logged in' do
      controller.log_in_user(user)
      current_user = controller.send(:current_user)
      expect(current_user).to eq user
    end

    it 'returns nil if there is no logged in user' do
      current_user = controller.send(:current_user)
      expect(current_user).to eq nil
    end
  end

  describe 'authorize method' do
    it 'returns nil if user is logged in' do
      controller.log_in_user(user)
      expect(controller.send(:authorize)).to eq nil
    end

    it 'redirects the user to the login page if it is not authorized' do
      controller.response = response
      controller.send(:authorize)
      expect(response).to redirect_to login_url
    end
  end
end
