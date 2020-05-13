class TransactionPage
  include Capybara::DSL

  def visit_page(transaction)
    visit("transactions/#{transaction.id}")
    self
  end

  def go_back
    click_on('Go back')
    self
  end
end
