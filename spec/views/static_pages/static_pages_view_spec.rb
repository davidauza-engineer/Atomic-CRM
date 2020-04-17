require 'rails_helper'

RSpec.describe 'static_pages/home.html.erb', type: :view do
  describe 'Home page' do
    before do
      render template: 'static_pages/home.html.erb'
    end

    it 'contains link to log in' do
      expect(rendered).to match(/#{login_path}/)
    end

    it 'contains link to sign up' do
      expect(rendered).to match(/#{signup_path}/)
    end
  end
end
