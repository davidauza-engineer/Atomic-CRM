require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  render_views
  let(:base_title) { ' | Atomic CRM' }
  let(:user) do
    User.create(email: 'example@test.com', password: 'secret_password',
                password_confirmation: 'secret_password')
  end

  def log_in_user
    post :create, params: { email: user.email, password: user.password }
  end

  describe 'index method' do
    it 'redirects to login_url' do
      get :index
      expect(response).to redirect_to(login_url)
    end
  end

  describe 'new method' do
    before do
      get :new
    end

    it 'responds with success when reached with GET' do
      expect(response).to have_http_status(:ok)
    end

    it 'has the right title' do
      expect(response.body).to have_title 'Log In' + base_title
    end
  end

  describe 'create method' do
    it 'successfully creates a new session with right input' do
      log_in_user
      expect(response).to redirect_to(root_url)
    end

    it 'successfully displays an error message if the email is not correct' do
      post :create, params: { email: 'example@testing.com', password: user.password }
      expect(response.body).to match(/Email or password is invalid./)
    end

    it 'successfully displays an error message if the password is not correct' do
      post :create, params: { email: user.email, password: 'wrond_password' }
      expect(response.body).to match(/Email or password is invalid./)
    end
  end

  describe 'destroy method' do
    it 'successfully destroy an existing session' do
      log_in_user
      delete :destroy
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'reset_password' do
    it 'redirects to login' do
      get :reset_password
      expect(response).to redirect_to(login_url)
    end
  end
end