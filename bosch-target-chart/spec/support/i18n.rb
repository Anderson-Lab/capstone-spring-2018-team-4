# Source: https://stackoverflow.com/questions/9564797/cant-pass-locale-to-capybaras-method-visit
class ActionView::TestCase::TestController
  def default_url_options(options={})
    { locale: I18n.default_locale }
  end
end

class ActionDispatch::Routing::RouteSet
  def default_url_options(options={})
    { locale: I18n.default_locale }
  end
end
