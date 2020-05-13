class NewTransactionForm
  include Capybara::DSL

  def visit_page
    visit('/transactions/new')
    self
  end

  def fill_in_with(params = {})
    fill_in('transaction_name', with: params.fetch(:name, 'My Transaction'))
    fill_in('transaction_description', with: params.fetch(:description, 'My Description'))
    fill_in('transaction_amount', with: params.fetch(:amount, 99.99))
    check('Sale')
    self
  end

  def submit
    click_on('Create')
    self
  end
end
