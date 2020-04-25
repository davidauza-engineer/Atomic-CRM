require 'rails_helper'

RSpec.describe TransactionsController do
  render_views

  context 'when logged in' do
    before do
      user = User.create(name: 'Test', email: 'test@email.com', password: 'secret')
      session[:user_id] = user.id
    end

    describe 'index action' do
      it 'displays the right title' do
        get :index
        expect(response.body).to match(/All my transactions | Atomic CRM/)
      end

      it 'sets @most_recent to true by default' do
        get :index
        expect(controller.most_recent).to eq true
      end

      it 'sets @most_recent to true if receives the param most_recent=true' do
        get :index, params: { most_recent: true }
        expect(controller.most_recent).to eq true
      end

      it 'sets @most_recent to false if receives the param most_recent=false' do
        get :index, params: { most_recent: false }
        expect(controller.most_recent).to eq false
      end

      it "appropriately calculates the user's total amount" do
        user = User.find(session[:user_id])
        user.transactions.create(amount: 77)
        user.transactions.create(amount: -5)
        get :index
        expect(controller.total_balance).to eq(72.0)
      end
    end

    describe 'search action' do
      before do
        get :search
      end

      it 'redirects to transactions_url' do
        expect(response).to redirect_to(transactions_url)
      end

      it 'notifies the user that the feature will be available soon' do
        expect(controller.flash.notice).to eq 'Search feature will be available soon.'
      end
    end
  end

  context 'when not logged in' do
    describe 'index action' do
      it 'redirects to login_url' do
        get :index
        expect(response).to redirect_to(login_url)
      end
    end

    describe 'search action' do
      it 'redirects to login_url' do
        get :search
        expect(response).to redirect_to(login_url)
      end
    end
  end
end
