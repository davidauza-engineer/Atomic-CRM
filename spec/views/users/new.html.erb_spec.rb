require 'rails_helper'

RSpec.describe 'users/new.html.erb', type: :view do
  before do
    @user = User.new
  end

  context 'when there are no errors' do
    before do
      render
    end

    it 'contains a link to go back to root_url' do
      expect(rendered).to match(/#{root_url}/)
    end

    it 'contains an input tag to submit the sign-up-form' do
      expect(rendered).to match(/form="sign-up-form"/)
    end

    it 'contains a link to upload pictures' do
      expect(rendered).to match(%r{href="/uploadpicture"})
    end

    it 'containes a field to submit the user name' do
      expect(rendered).to match(/name="user\[name\]"/)
    end

    it 'contains a field to submit the user email' do
      expect(rendered).to match(/name="user\[email\]"/)
    end

    it 'contains a field to submit the user password' do
      expect(rendered).to match(/name="user\[password\]"/)
    end
  end

  context 'when there are errors' do
    it 'display the user errors if any' do
      # rubocop:disable RSpec/InstanceVariable
      @user.errors.add(:test, 'test error')
      # rubocop:enable  RSpec/InstanceVariable
      render
      expect(rendered).to match(/Form is invalid/)
    end
  end
end
