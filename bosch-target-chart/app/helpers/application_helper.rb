module ApplicationHelper
  def twitterized_type(type)
    case type.to_sym
    when :alert
      'alert-danger'
    when :error
      'alert-danger'
    when :notice
      'alert-warning'
    when :success
      'alert-success'
    else
      ''
    end
  end
end
