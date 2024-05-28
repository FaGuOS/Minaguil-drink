module ApplicationHelper
  def key_to_bootstrap_class(key)
    case key
    when "notice" then "success"
    when "alert" then "danger"
    else key
    end
  end
  def display_rate(rate)
    rate.present? ? "#{rate} / 5" : "考え中…"
  end
end
