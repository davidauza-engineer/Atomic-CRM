require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  render_views
  let(:base_title) { ' | Atomic CRM' }

  context 'when visiting Home page' do
    before do
      get :home
    end

    it 'successfully gets home' do
      expect(response.code).to eq '200'
    end

    it 'has the right title' do
      expect(response.body).to have_title 'Home' + base_title
    end
  end
end
