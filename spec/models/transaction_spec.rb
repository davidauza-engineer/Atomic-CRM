require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:user) { User.create(name: 'Test', email: 'test@user.com', password: 'secret') }
  let(:transaction) do
    described_class.new(author_id: user.id, name: 'Car Sale',
                        description: 'Porsche 911 750z', amount: 150_000)
  end

  describe 'Validations' do
    context 'with author_id field' do
      it 'validates a transaction with a valid user id' do
        expect(transaction.valid?).to eq true
      end

      it 'validates a transaction with a negative amount' do
        transaction.amount = -5
        expect(transaction._validators?).to eq(true)
      end

      it 'rejects a transaction with a non existent user id' do
        transaction.author_id = 3459
        expect(transaction.valid?).to eq false
      end
    end

    context 'with name field' do
      it 'validates a transaction with a name' do
        expect(transaction.valid?).to eq true
      end

      it 'rejects a transaction with a name longer than 255 characters' do
        transaction.name = 'a' * 256
        expect(transaction.valid?).to eq false
      end

      it 'rejects a transaction with an empty name' do
        transaction.name = ''
        expect(transaction.valid?).to eq false
      end

      it 'rejects a transaction with a nil name' do
        transaction.name = nil
        expect(transaction.valid?).to eq false
      end
    end

    context 'with description field' do
      it 'validates a transaction with a description' do
        expect(transaction.valid?).to eq true
      end

      it 'validates a transaction without a description' do
        transaction.description = ''
        expect(transaction.valid?).to eq true
      end

      it 'rejects a transaction with a nil description' do
        transaction.description = nil
        expect(transaction.valid?).to eq false
      end

      it 'rejects a transaction with a description longer that 1530 characters' do
        transaction.description = 'a' * 1531
        expect(transaction.valid?).to eq false
      end
    end

    context 'with amount field' do
      it 'validates a transaction with an amount that matches the format digit.twoDecimals' do
        expect(transaction.valid?).to eq true
      end

      it 'rejects a transaction without an amount' do
        transaction.amount = ''
        expect(transaction.valid?).to eq false
      end

      it 'rejects a transaction with a nil amount' do
        transaction.amount = nil
        expect(transaction.valid?).to eq false
      end
    end
  end

  describe 'Associations' do
    it 'returns the right user' do
      transaction.save
      stored_transaction = described_class.first
      expect(stored_transaction.user).to eq user
    end
  end
end
