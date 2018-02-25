# Override the default DeviseHelper
# Source: https://github.com/plataformatec/devise/blob/master/app/helpers/devise_helper.rb

module DeviseHelper
  def devise_error_messages!
    return "" unless devise_error_messages?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

    html = <<-HTML
    <div id='errorMessages' class='alert alert-danger'>
      <ul class='list-unstyled mb-0'>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

end