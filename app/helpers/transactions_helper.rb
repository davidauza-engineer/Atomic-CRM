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
end
