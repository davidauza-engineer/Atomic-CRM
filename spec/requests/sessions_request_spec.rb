require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /sessions' do
    it 'redirects to login_url' do
      get '/sessions'
      expect(response).to have_http_status(:found)
    end
  end

  describe 'GET /sessions/new' do
    it 'returns http success' do
      get '/sessions/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST sessions/' do
    it 'returns http success' do
      post '/sessions', params: { email: '', password: '' }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /logout' do
    it 'redirects to root_url' do
      delete '/logout'
      expect(response).to have_http_status(:found)
    end
  end

  describe 'GET /resetpassword' do
    it 'redirects to login_path' do
      get '/resetpassword'
      expect(response).to have_http_status(:found)
    end
  end
end
