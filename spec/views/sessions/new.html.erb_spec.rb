require 'rails_helper'

RSpec.describe 'sessions/new.html.erb', type: :view do
  before do
    render
  end

  it 'contains a link to the Home page' do
    expect(rendered).to match(/#{root_url}/)
  end

  it 'contains a login submit input tag' do
    expect(rendered).to match(/form="login-form"/)
  end

  it 'contains an email field' do
    expect(rendered).to match(/name="email"/)
  end

  it 'contains a password field' do
    expect(rendered).to match(/name="password"/)
  end

  it 'contains a forgot password link' do
    expect(rendered).to match(%r{<a href="/resetpassword"})
  end
end
