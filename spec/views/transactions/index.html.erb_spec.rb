require 'rails_helper'

RSpec.describe 'transactions/index.html.erb', type: :view do
  before do
    user = User.create(name: 'Test', email: 'email@test.com', password: 'secret')
    @user_transaction = user.transactions.create(amount: 99.99, name: 'Test Transaction')
    @user_transactions = user.transactions
    @total_balance = user.transactions.sum(:amount)
    @user_transactions_categories = [[]]
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
    expect(rendered).to match(/\$99.99/)
  end

  describe 'transaction cards' do
    shared_examples 'card content' do
      it 'displays the transaction name' do
        expect(rendered).to match(/Test Transaction/)
      end

      it 'displays the transaction created_at date in a dd Mon yy format' do
        # rubocop:disable RSpec/InstanceVariable
        expect(rendered).to match(/#{@user_transaction.created_at.strftime("%d %b %Y")}/)
        # rubocop:enable RSpec/InstanceVariable
      end

      it "displays the transaction's amount" do
        expect(rendered).to match(/99.99/)
      end
    end

    context 'with uncategorized transaction' do
      it_behaves_like 'card content'

      it "contains an uncategorized-background css class for the icon's transaction" do
        expect(rendered).to match(/uncategorized-background/)
      end
    end

    context 'with categorized transaction' do
      it_behaves_like 'card content'

      it "contains a category-background css class for the icon's transaction" do
        @user_transactions_categories = [[Category.new]]
        render
        expect(rendered).to match(/category-background/)
      end
    end
  end

  describe 'ADD NEW button' do
    it 'contains an ADD NEW text' do
      expect(rendered).to match(/ADD NEW/)
    end

    it 'contains a link to new_transaction_path' do
      expect(rendered).to match(/transactions\/new/)
    end
  end
end
