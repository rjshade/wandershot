module ApplicationHelper
  def wandershot_text( darkbg = false )
    "<span class='wandershot-logo #{darkbg ? "dark-bg" : "light-bg"}'><span class='wander'>wander</span><span class='shot'>shot</span></span>".html_safe
  end
end
