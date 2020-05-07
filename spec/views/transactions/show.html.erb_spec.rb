require 'rails_helper'

RSpec.describe 'transactions/show.html.erb', type: :view do
  before do
    user = FactoryBot.create(:user)
    transaction = FactoryBot.create(:transaction, name: 'Test title',
                                                  description: 'Test description', user: user)
    category = FactoryBot.create(:category, icon: 'sale.svg', user: user)
    CategoryTransaction.create(transaction_id: transaction.id, category_id: category)
    @categories_transactions = transaction.categories_transactions
    @icon = category.icon
    @transaction = transaction
    render
  end

  # rubocop:disable RSpec/InstanceVariable
  let(:transaction) { @transaction }
  # rubocop:enable RSpec/InstanceVariable

  it 'contains a link to the transactions_path' do
    expect(rendered).to match(/#{transactions_path}/)
  end

  it 'contans a DETAILS title' do
    expect(rendered).to match(/DETAILS/)
  end

  it 'displays the transaction icon' do
    expect(rendered).to match(/<svg /)
  end

  it 'displays the transaction name' do
    expect(rendered).to match(/Test title/)
  end

  it 'displays the transaction description' do
    expect(rendered).to match(/Test description/)
  end

  it 'displays the transaction id' do
    expect(rendered).to match(/#{transaction.id}/)
  end

  it 'displays the transaction created_at date' do
    expect(rendered).to match(/#{transaction.created_at.strftime('%d %b %Y')}/)
  end

  it 'displays the transaction amount' do
    expect(rendered).to match(/#{transaction.amount}/)
  end
end
