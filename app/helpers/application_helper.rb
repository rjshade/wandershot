module ApplicationHelper
  def wandershot_text( darkbg = false )
    "<span class='wandershot-logo #{darkbg ? "dark-bg" : "light-bg"}'><span class='wander'>wander</span><span class='shot'>shot</span></span>".html_safe
  end
  def twitterized_type(type)
    case type
      when :alert
        "alert-warning"
      when :error
        "alert-error"
      when :notice
        "alert-info"
      when :success
        "alert-success"
      else
        type.to_s
    end
  end
end
