require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  render_views
  let(:base_title) { ' | Atomic CRM' }
  let(:user) do
    User.create(email: 'example@test.com', password: 'secret_password',
                name: 'test_user')
  end

  def log_in_user
    post :create, params: { email: user.email, password: user.password, name: user.name }
  end

  describe 'index method' do
    it 'redirects to login_url' do
      get :index
      expect(response).to redirect_to(login_url)
    end
  end

  describe 'new method' do
    context 'when logged in' do
      it 'redirects to root_url when a user is logged in' do
        session[:user_id] = user.id
        get :new
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when not logged in' do
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
    before do
      log_in_user
      delete :destroy
    end

    it 'successfully destroy an existing session' do
      expect(session[:user_id]).to eq nil
    end

    it 'sucessfully redirects to root_url after destroying a session' do
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
