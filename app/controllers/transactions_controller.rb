class TransactionsController < ApplicationController
  before_action :authorize
  # TODO: Urgent! Analize and implement authorization restrictions

  attr_reader :most_recent
  attr_reader :total_balance
  attr_reader :user_transactions
  attr_reader :user_transactions_categories
  attr_reader :transaction

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
    @icon = if @categories_transactions.empty?
              'all_my_uncategorized_transactions.svg'
            else
              Category.find(@categories_transactions.main).icon
            end
  end

  def new
    @transaction = Transaction.new
    @available_categories = fetch_categories
  end

  def create
    @transaction = current_user.transactions.build(remove_unselected_categories(transaction_params))
    if @transaction.save
      redirect_to transaction_url(@transaction), notice: 'Transaction created successfully.'
    else
      @available_categories = fetch_categories
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
    params.require(:transaction).permit(
      :name, :description, :amount, categories_transactions_attributes: %i[category_id selected]
    )
  end

  # This method removes the params for the categories_transactions_attributes that
  # the user hasn't checked in the form
  def remove_unselected_categories(params)
    params[:categories_transactions_attributes].each do |category_transaction|
      if category_transaction[1][:selected] == '0'
        params[:categories_transactions_attributes].delete(category_transaction[0])
      end
    end
    params
  end

  def fetch_categories
    # Load default categories created by the admin
    available_categories = Category.where('user_id = ?', 1)
    # Load categories created by the user
    active_user = current_user
    available_categories += Category.where('user_id = ?', active_user.id) unless active_user.id == 1
    available_categories
  end
end
