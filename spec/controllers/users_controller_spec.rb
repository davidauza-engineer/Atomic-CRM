require 'rails_helper'

RSpec.describe UsersController do
  render_views
  let(:base_title) { ' | Atomic CRM' }
  let(:user_hash) do
    { user: { name: 'Test User', email: 'example@test.com', password: 'secret' } }
  end

  let(:bad_user_hash) do
    { user: { name: 'Bad Test User', email: 'baduser@email.com', password: 'baduser',
              id: -1000 } }
  end

  describe 'index method' do
    it 'redirects to signup_url' do
      get :index
      expect(response).to redirect_to(signup_url)
    end
  end

  describe 'new method' do
    context 'when user is logged in' do
      it 'redirects to root_url' do
        session[:user_id] = User.create(user_hash[:user]).id
        get :new
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when user is not logged in' do
      before do
        get :new
      end

      it 'responds with success when reached with GET' do
        expect(response).to have_http_status(:ok)
      end

      it 'has the right title' do
        title = 'Sign Up' + base_title
        expect(response.body).to match(/#{title}/)
      end
    end
  end

  describe 'create method' do
    it 'successfully creates a user with the right input' do
      post :create, params: user_hash
      expect(response).to redirect_to(root_url)
    end

    it 'creates an user filtering the non-permitted attributes' do
      post :create, params: bad_user_hash
      expect(response).to redirect_to(root_url)
    end

    context 'when wrong input is submitted' do
      it "doesn't create a user without name" do
        user_hash[:user][:name] = ''
        post :create, params: user_hash
        expect(response.body).to match(/Name can&#39;t be blank/)
      end

      it "doesn't create a user with a name longer than 50 characters" do
        user_hash[:user][:name] = 'a' * 51
        post :create, params: user_hash
        expect(response.body).to match(/Name is too long \(maximum is 50 characters\)/)
      end

      it "doesn't create a user with an already registered email" do
        post :create, params: user_hash
        post :create, params: user_hash
        expect(response.body).to match(/Email has already been taken/)
      end

      it "doesn't create a user without email" do
        user_hash[:user][:email] = ''
        post :create, params: user_hash
        expect(response.body).to match(/Email can&#39;t be blank/)
      end

      it "doesn't create a user with an email longer than 255 characters" do
        user_hash[:user][:email] = ('a' * 255) + '@email.com'
        post :create, params: user_hash
        expect(response.body).to match(/Email is too long \(maximum is 255 characters\)/)
      end

      it "doesn't create a user with an email that doesn't match an email format" do
        user_hash[:user][:email] = 'test@example'
        post :create, params: user_hash
        expect(response.body).to match(/Email is invalid/)
      end

      it "doesn't create an user without a password" do
        user_hash[:user][:password] = ''
        post :create, params: user_hash
        expect(response.body).to match(/Password can&#39;t be blank/)
      end

      it "doesn't create an user with a password shorter than 6 characters" do
        user_hash[:user][:password] = 'fido'
        post :create, params: user_hash
        expect(response.body).to match(/Password is too short \(minimum is 6 characters\)/)
      end

      it "doesn't create an user with a nil password" do
        user_hash[:user][:password] = nil
        post :create, params: user_hash
        expect(response.body).to match(/Password can&#39;t be blank/)
      end
    end
  end

  describe 'upload_picture method' do
    it 'redirects to signup_url' do
      get :upload_picture
      expect(response).to redirect_to(signup_url)
    end
  end

  describe 'profile method' do
    context 'when user is logged in' do
      let(:user) { User.create(user_hash[:user]) }

      before do
        session[:user_id] = user.id
      end

      it 'has http status success' do
        get :profile
        expect(response.code).to eq '200'
      end

      it 'successfully retrieves the right user from the database' do
        expect(controller.profile).to eq user
      end
    end

    context 'when user is not logged in' do
      it 'redirects to login page' do
        get :profile
        expect(response).to redirect_to(login_url)
      end
    end
  end

  describe 'user_params method' do
    it 'filters non-permitted attributes' do
      controller.params = bad_user_hash
      filtered_hash = controller.send(:user_params)
      expected_hash = '{"name"=>"Bad Test User", "email"=>"baduser@email.com",' \
                      ' "password"=>"baduser"}'
      expect(filtered_hash.to_s).to eq(expected_hash)
    end
  end
end
