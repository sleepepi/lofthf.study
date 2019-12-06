# frozen_string_literal: true

# Generic methods used across all views.
module ApplicationHelper
  def format_date(date)
    return "" if date.blank?

    date.strftime("%b %-d, %Y")
  end

  def simple_check(checked)
    checked ? icon("fas", "check-square") : icon("far", "square")
  end
end
