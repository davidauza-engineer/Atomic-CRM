require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    described_class.new(name: 'Test User', email: 'example@test.com', password: 'secret')
  end

  describe 'Validations tests' do
    context 'when right input is submitted' do
      it 'successfully creates a new user' do
        expect(user.valid?).to eq true
      end
    end

    context 'when wrong input is submitted' do
      it "doesn't validates a user without name" do
        user.name = ''
        expect(user.valid?).to eq false
      end

      it "doesn't validate a user with a name longer than 50 characters" do
        user.name = 'a' * 51
        expect(user.valid?).to eq false
      end

      it "doesn't validate a user with an already registered email" do
        user.save
        new_user = described_class.new(name: 'Test user 2', email: 'example@test.com',
                                       password: 'secret')
        expect(new_user.valid?).to eq false
      end

      it "doesn't validate a user without email" do
        user.email = ''
        expect(user.valid?).to eq false
      end

      it "doesn't validate a user with an email longer than 255 characters" do
        user.email = ('a' * 255) + '@email.com'
        expect(user.valid?).to eq false
      end

      it "doesn't validate a user with an email that doesn't match an email format" do
        user.email = 'test@example'
        expect(user.valid?).to eq false
      end

      it "doesn't validate a user without a password" do
        new_user = described_class.new(name: 'Test Name', email: 'email@email.com',
                                       password: '')
        expect(new_user.valid?).to eq false
      end

      it "doesn't validate a user with a password shorter than 6 characters" do
        user.password = 'fido'
        expect(user.valid?).to eq false
      end

      it "doesn't validate a user with a nil password" do
        new_user = described_class.new(name: 'Test Name', email: 'email@email.com',
                                       password: nil)
        expect(new_user.valid?).to eq false
      end
    end
  end

  describe 'Associations tests' do
    before do
      user.save
      user.transactions.create(amount: 44)
    end

    it "successfully returns the user's transactions" do
      expect(user.transactions.first.amount).to eq 44
    end

    it 'successfully builds a new transaction with the right user id' do
      transaction = user.transactions.build
      expect(transaction.author_id).to eq user.id
    end

    it 'successfully creates a new transaction in the database' do
      total_transactions = user.transactions.count
      user.transactions.create
      expect(user.transactions.count).to eq(total_transactions + 1)
    end
  end
end
