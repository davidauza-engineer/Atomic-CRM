class LoginForm
  include Capybara::DSL

  def visit_page
    visit('/login')
    self
  end

  def login_as(user)
    fill_in('email', with: user.email)
    fill_in('password', with: user.password)
    click_on('Log In')
    self
  end
end
