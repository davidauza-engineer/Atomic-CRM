require 'rails_helper'

RSpec.describe 'users/profile.html.erb', type: :view do
  before do
    @user = User.create(name: 'Daniel Houseman', email: 'daniel@houseman.com',
                        password: 'secret')
    render
  end

  it 'contains a profile picture placeholder' do
    expect(rendered).to match(/width="332px"/)
  end

  it 'displays the right user name' do
    expect(rendered).to match(/Daniel Houseman/)
  end

  it 'contains a link to all my transactions' do
    expect(rendered).to match(/All my transactions/)
  end

  it 'contains a link to all my uncategorized transactions' do
    expect(rendered).to match(/All my uncategorized transactions/)
  end

  it 'contains a link to all categories' do
    expect(rendered).to match(/All categories/)
  end

  it 'contains a link to logout' do
    expect(rendered).to match(/Logout/)
  end
end
