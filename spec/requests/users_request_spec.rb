require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'redirects to signup_url' do
      get '/users'
      expect(response).to have_http_status(:found)
    end
  end

  describe 'GET /users/new' do
    it 'returns http success' do
      get '/users/new'
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /users' do
    it 'returns http success' do
      post '/users', params: { user: { name: '', email: '', password: '' } }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /uploadpicture' do
    it 'redirects to signup_url' do
      get '/uploadpicture'
      expect(response).to have_http_status(:found)
    end
  end
end
