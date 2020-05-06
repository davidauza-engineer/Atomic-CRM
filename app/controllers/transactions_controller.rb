class TransactionsController < ApplicationController
  before_action :authorize
  # TODO: Urgent! Analize and implement authorization restrictions

  attr_reader :most_recent
  attr_reader :total_balance
  attr_reader :user_transactions
  attr_reader :user_transactions_categories
  attr_accessor :categories

  def index
    @most_recent = true
    @most_recent = false if params[:most_recent] == 'false'
    user = User.find(current_user.id)
    @user_transactions =
      @most_recent ? user.transactions.newest_first : user.transactions.oldest_first
    @total_balance = @user_transactions.sum(:amount)
    @user_transactions_categories =
      @user_transactions.includes(:categories).map(&:categories)
  end

  def show
    @transaction = Transaction.find(params[:id])
    @categories_transactions = @transaction.categories_transactions
    @icon = @categories_transactions.empty? ? 'all_my_uncategorized_transactions.svg' : Category.find(@categories_transactions.main).icon
  end

  def new
    @transaction = Transaction.new
    @categories = []
    @categories = Category.all unless Category.all.nil?
    # @categories += current_user.categories unless current_user.categories.nil?
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      redirect_to transaction_path(@transaction.id), notice: 'Transaction created!'
    else
      render :new
    end
  end

  def uncategorized; end

  def search
    flash.notice = 'Search feature will be available soon.'
    redirect_to transactions_url
  end

  private

  def transaction_params
    params.require(:transaction).permit(:name, :description, :amount)
  end
end
