require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TransactionsHelper. For example:
#
# describe TransactionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TransactionsHelper, type: :helper do
  describe 'check_first_sub_bar_link method' do
    it 'returns a path that contains most_recent=true if @most_recent is true' do
      expect(check_first_sub_bar_link(true)).to match(/most_recent=true/)
    end

    it 'returns a path that contains most_recent=false if @most_recent is false' do
      expect(check_first_sub_bar_link(false)).to match(/most_recent=false/)
    end
  end

  describe 'check_first_sub_bar_link_text method' do
    it "returns 'Most recent' if @most_recent = true" do
      expect(check_first_sub_bar_link_text(true)).to eq 'Most recent'
    end

    it "returns 'Most ancient' if @most_recent = false" do
      expect(check_first_sub_bar_link_text(false)).to eq 'Most ancient'
    end
  end

  describe 'check_second_sub_bar_link method' do
    it 'returns a path that contains most_recent=false if @most_recent = true' do
      expect(check_second_sub_bar_link(true)).to match(/most_recent=false/)
    end

    it 'returns a path that contains most_recent=true if @most_recent = false' do
      expect(check_second_sub_bar_link(false)).to match(/most_recent=true/)
    end
  end

  describe 'check_second_sub_bar_link_text method' do
    it "returns 'Most ancient' if @most_recent = true" do
      expect(check_second_sub_bar_link_text(true)).to eq 'Most ancient'
    end

    it "returns 'Most recent' if @most_recent = false" do
      expect(check_second_sub_bar_link_text(false)).to eq 'Most recent'
    end
  end

  describe 'category? method' do
    let(:transaction_categories) { [[], [Category.new]] }

    it 'returns uncategorized-background if transaction has no category' do
      expect(category?(transaction_categories[0])).to eq('uncategorized-background')
    end

    it 'returns category-background if transaction has any category' do
      expect(category?(transaction_categories[1])).to eq('category-background')
    end
  end

  describe 'transaction_icon method' do
    let(:transaction_categories) { [[], [Category.new(icon: 'test_icon.svg'), Category.new]] }

    it 'returns all_my_uncategorized_transactions.svg if the transaction has no categories' do
      expect(transaction_icon(transaction_categories[0])).to
      eq('all_my_uncategorized_transactions.svg')
    end

    it 'returns the icon of the first category if the transaction has any category' do
      expect(transaction_icon(transaction_categories[1])).to eq('test_icon.svg')
    end
  end
end
