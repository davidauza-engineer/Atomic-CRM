require 'rails_helper'
require_relative '../support/login_form'
require_relative '../support/profile_page'
require_relative '../support/transactions_page'
require_relative '../support/new_transaction_form'
require_relative '../support/transaction_page'

RSpec.feature 'create transaction' do
  given(:user) { FactoryBot.create(:user) }
  given(:login_form) { LoginForm.new }
  given(:profile_page) { ProfilePage.new }
  given(:transactions_page) { TransactionsPage.new }
  given(:new_transaction_form) { NewTransactionForm.new }
  given(:transaction_page) { TransactionPage.new }

  background do
    FactoryBot.create(:category, name: 'Sale', user_id: user.id)
  end

  scenario 'logged in user creates a new transaction' do
    login_form.visit_page.login_as(user)
    expect(page).to have_content('Logged in!')

    profile_page.view_all_my_transactions
    expect(page).to have_content('TRANSACTIONS')

    transactions_page.create_new_transaction
    expect(page).to have_content('NEW TRANSACTION')

    new_transaction_form.fill_in_with(
      FactoryBot.attributes_for(:transaction, name: 'Last transaction')
    ).submit
    expect(page).to have_content('Transaction created successfully.')
    expect(page).to have_content('DETAILS')
    last_transaction = Transaction.last
    expect(page).to have_content("Transaction Nº#{last_transaction.id}")
    expect(last_transaction.name).to eq('Last transaction')

    last_category_transaction = CategoryTransaction.last
    expect(last_category_transaction.transaction_id).to eq(last_transaction.id)
    category = Category.first
    expect(last_category_transaction.category_id).to eq(category.id)

    transaction_page.go_back
    expect(page).to have_content('TRANSACTIONS')
  end
end
