require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  render_views
  let(:base_title) { ' | Atomic CRM' }

  context 'when user is logged in' do
    it 'redirects to profile_url' do
      session[:user_id] = User.create(name: 'User', email: 'user@email.com',
                                      password: 'secret').id
      get :home
      expect(response).to redirect_to(profile_url)
    end
  end

  context 'when user is not logged in' do
    before do
      get :home
    end

    it 'successfully gets home' do
      expect(response.code).to eq '200'
    end

    it 'has the right title' do
      expect(response.body).to have_title 'Home' + base_title
    end
  end
end
