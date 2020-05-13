class ProfilePage
  include Capybara::DSL

  def visit_page
    visit('/profile')
    self
  end

  def view_all_my_transactions
    click_on('All my transactions')
    self
  end
end
