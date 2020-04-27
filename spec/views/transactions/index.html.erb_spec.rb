require 'rails_helper'

RSpec.describe 'transactions/index.html.erb', type: :view do
  before do
    user = User.create(name: 'Test', email: 'email@test.com', password: 'secret')
    user.transactions.create(amount: 99.99)
    @user_transactions = user.transactions
    @total_balance = user.transactions.sum(:amount)
    render
  end

  it 'contains a link to the root_url' do
    expect(rendered).to match(/#{root_path}/)
  end

  it 'contains a link to transactions/search' do
    expect(rendered).to match(/#{transactions_actions_search_path}/)
  end

  it 'contains a link to most_recent=true' do
    expect(rendered).to match(%r{/transactions\?most_recent=true})
  end

  it 'contains a link to most_recent=false' do
    expect(rendered).to match(%r{/transactions\?most_recent=false})
  end

  it "contains a span with the user's total balance" do
    expect(rendered).to match(%r{<span>\$99.99<\/span>})
  end
end
