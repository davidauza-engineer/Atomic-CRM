require 'rails_helper'

RSpec.describe TransactionsController do
  render_views

  context 'when logged in' do
    before do
      user = FactoryBot.create(:user, id: 99)
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
      let(:category) { FactoryBot.create(:category, user: user, icon: 'sale.svg') }

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

      it 'assigns the corresponding category icon to @icon when there is a category_transaction',
         skip_before: true do
        CategoryTransaction.create(category_id: category.id, transaction_id: transaction.id)
        get :show, params: { id: transaction.id }
        expect(assigns(:icon)).to eq('sale.svg')
      end

      it 'renders :show template' do
        expect(response).to render_template(:show)
      end
    end

    describe 'GET new' do
      before do
        get :new
      end

      it 'assigns new Transaction to @transaction' do
        expect(assigns(:transaction)).to be_a_new(Transaction)
      end

      it 'assigns available categories to @available_categories', skip_before: true do
        user = User.find(session[:user_id])
        FactoryBot.create(:category, user: user)
        get :new
        expect(assigns(:available_categories)).to include(user.categories.first)
      end

      it 'renders :new template' do
        expect(response).to render_template(:new)
      end
    end

    describe 'POST create' do
      context 'with valid data' do
        before do
          post :create, params: { transaction: FactoryBot.attributes_for(
            :transaction, categories_transactions_attributes: [[]]
          ) }
        end

        it 'assigns the new transaction to @Transaction' do
          expect(assigns(:transaction)).to be_an_instance_of(Transaction)
        end

        it 'redirects to the transaction_url' do
          transaction = controller.transaction
          expect(response).to redirect_to(transaction_url(transaction))
        end

        it 'displays a message confirming the transaction was created' do
          expect(flash[:notice]).to match(/Transaction created successfully./)
        end
      end

      context 'with invalid data' do
        let(:user) { User.find(session[:user_id]) }

        before do
          FactoryBot.create(:category, user: user)
          post :create, params: { transaction: FactoryBot.attributes_for(
            :transaction, name: '', categories_transactions_attributes: [[]]
          ) }
        end

        it 'assigns available categories to @available_categories' do
          expect(assigns(:available_categories)).to include(user.categories.first)
        end

        it 'renders :new template' do
          expect(response).to render_template(:new)
        end
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

    describe 'transaction_params private method' do
      it 'filters non-permitted attributes' do
        controller.params = { transaction: FactoryBot.attributes_for(:transaction, user: 182) }
        filtered_params = controller.send(:transaction_params)
        expect(filtered_params).not_to include(:user)
      end
    end

    describe 'remove_unselected_categories private method' do
      # rubocop:disable RSpec/ExampleLength, Layout/LineLength
      it 'removes the categories_transactions_attributes for which selected value is 0' do
        controller.params = { transaction: FactoryBot.attributes_for(
          :transaction, categories_transactions_attributes: { '0' => { category_id: 1, selected: 0 },
                                                              '1' => { category_id: 1, selected: 1 } }
        ) }
        filtered_params = controller.send(:remove_unselected_categories, controller.params[:transaction])
        expect(filtered_params).not_to include(filtered_params[:categories_transactions_attributes][0])
      end
      # rubocop:enable RSpec/ExampleLength, Layout/LineLength
    end

    describe 'fetch_categories private method' do
      it 'includes the categories created by the user' do
        user = User.find(session[:user_id])
        user_category = FactoryBot.create(:category, user: user)
        available_categories = controller.send(:fetch_categories)
        expect(available_categories).to include(user_category)
      end

      it 'includes the default categories created by the admin' do
        admin = User.create!(FactoryBot.attributes_for(:user, id: 1))
        admin_category = FactoryBot.create(:category, user: admin)
        available_categories = controller.send(:fetch_categories)
        expect(available_categories).to include(admin_category)
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

    describe 'GET new' do
      it 'redirects to login_url' do
        get :new
        expect(response).to redirect_to(login_url)
      end
    end

    describe 'POST create' do
      it 'redirects to login_url' do
        post :create, params: { transaction: FactoryBot.attributes_for(
          :transaction, categories_transactions_attributes: [[]]
        ) }
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
