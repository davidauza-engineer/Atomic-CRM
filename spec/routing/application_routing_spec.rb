require 'rails_helper'

RSpec.describe 'Routing tests', type: :routing do
  describe 'root route' do
    it 'correctly points to static_pages#home' do
      expect(get: '/').to route_to(controller: 'static_pages', action: 'home')
    end
  end

  describe 'session routes' do
    it 'GET /login correctly routes to sessions#new' do
      expect(get: '/login').to route_to(controller: 'sessions', action: 'new')
    end

    it 'POST /login correctly routes to sessions#create' do
      expect(post: '/login').to route_to(controller: 'sessions', action: 'create')
    end

    it 'DELETE /logout correctly routes to sessions#destroy' do
      expect(delete: '/logout').to route_to(controller: 'sessions', action: 'destroy')
    end

    it 'GET /pasword-reset correctly routes to sessions#reset_password' do
      expect(get: '/resetpassword').to route_to(controller: 'sessions', action: 'reset_password')
    end
  end

  describe 'user routes' do
    it 'GET /signup correctly routes to users#new' do
      expect(get: '/signup').to route_to(controller: 'users', action: 'new')
    end

    it 'POST /signup correctly routes to users#create' do
      expect(post: '/signup').to route_to(controller: 'users', action: 'create')
    end

    it 'GET /profile correctly route to users#profile' do
      expect(get: '/profile').to route_to(controller: 'users', action: 'profile')
    end

    it 'GET /uploadpicture correctly routes to users#upload_picture' do
      expect(get: '/uploadpicture').to route_to(controller: 'users', action: 'upload_picture')
    end
  end
end
