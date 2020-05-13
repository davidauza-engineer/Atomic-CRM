class TransactionsPage
  include Capybara::DSL

  def visit_page
    visit('/transactions')
    self
  end

  def create_new_transaction
    click_on('ADD NEW')
    self
  end
end
