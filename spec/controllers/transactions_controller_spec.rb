require 'rails_helper'

RSpec.describe TransactionsController do
  render_views

  context 'when logged in' do
    before do
      user = User.create(name: 'Test', email: 'test@email.com', password: 'secret')
      session[:user_id] = user.id
    end

    describe 'index action' do
      before do
        user = User.find(session[:user_id])
        user.transactions.create(amount: 77)
        second_transaction = user.transactions.create(amount: -5)
        category = Category.create(name: 'Test category')
        CategoryTransaction.create(category_id: category.id, transaction_id: second_transaction.id)
      end

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
        get :index
        expect(controller.total_balance).to eq(72.0)
      end

      it "gets user's transactions sorted by newest first when most_recent = true" do
        get :index
        expect(controller.user_transactions.first.amount.to_f).to eq(-5.0)
      end

      it "gets user's transactions sorted by oldest first when most_recent = false" do
        get :index, params: { most_recent: false }
        expect(controller.user_transactions.first.amount.to_f).to eq(77)
      end

      it 'correctly creates user_transactions_category array' do
        get :index
        transaction = Transaction.find_by(amount: -5)
        expect(controller.user_transactions_categories[0]).to eq(transaction.categories)
      end
    end

    describe 'GET show' do
      let(:user) { FactoryBot.create(:user) }
      let(:transaction) { FactoryBot.create(:transaction, user: user) }
      let(:category) { FactoryBot.create(:category, user: user) }

      before do
        get :show, params: { id: transaction.id }
      end

      it 'assigns requested transaction to @transaction' do
        expect(assigns(:transaction)).to eq(transaction)
      end

      it 'assigns an empty collection to @categories_transactions when there are no
      categories_transactions' do
        expect(assigns(:categories_transactions)).to be_empty
      end

      it "assigns 'all_my_uncategorized_transactions.svg' to @icon when there are no
      categories_transactions" do
        expect(assigns(:icon)).to eq('all_my_uncategorized_transactions.svg')
      end

      it 'assigns the existing category_transaction to @categories_transactions when there is a
      category_transaction' do
        category_transaction = CategoryTransaction.create(category_id: category.id,
                                                          transaction_id: transaction.id)
        expect(assigns(:categories_transactions)).to include(category_transaction)
      end

      it 'assigns the corresponding category icon to @icon when there is a category_transaction'

      it 'renders :show template' do
        expect(response).to render_template(:show)
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
