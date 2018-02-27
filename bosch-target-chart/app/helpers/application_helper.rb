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

  def valid_hex?(value)
    # Regex Source: https://coderwall.com/p/upx61q/css-hex-color-validation-in-rails
    /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/.match?(value)
  end

  module_function :valid_hex?
end
