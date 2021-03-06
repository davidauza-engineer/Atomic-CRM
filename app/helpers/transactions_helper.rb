module TransactionsHelper
  def check_first_sub_bar_link(most_recent)
    if most_recent
      '/transactions?most_recent=true'
    else
      '/transactions?most_recent=false'
    end
  end

  def check_first_sub_bar_link_text(most_recent)
    if most_recent
      'Most recent'
    else
      'Most ancient'
    end
  end

  def check_second_sub_bar_link(most_recent)
    check_first_sub_bar_link(!most_recent)
  end

  def check_second_sub_bar_link_text(most_recent)
    check_first_sub_bar_link_text(!most_recent)
  end

  def category?(transaction_categories)
    return 'category-background' unless transaction_categories.empty?

    'uncategorized-background'
  end

  def transaction_icon(transact_categories)
    return 'all_my_uncategorized_transactions.svg' if transact_categories.empty?

    transact_categories.first.icon
  end

  def transaction_name_value(transaction)
    (transaction.name unless transaction.name == 'My transaction') || ''
  end

  def transaction_amount_value(transaction)
    # rubocop:disable Style/NumericPredicate
    (transaction.amount unless transaction.amount == 0) || 0.00
    # rubocop:enable Style/NumericPredicate
  end
end
