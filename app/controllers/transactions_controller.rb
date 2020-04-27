class TransactionsController < ApplicationController
  before_action :authorize

  attr_reader :most_recent
  attr_reader :total_balance

  def index
    @most_recent = true
    @most_recent = false if params[:most_recent] == 'false'
    user = User.find(current_user.id)
    @user_transactions = @most_recent ? user.transactions.newest_first : user.transactions.oldest_first
    @total_balance = @user_transactions.sum(:amount)
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def uncategorized; end

  def search
    flash.notice = 'Search feature will be available soon.'
    redirect_to transactions_url
  end
end
