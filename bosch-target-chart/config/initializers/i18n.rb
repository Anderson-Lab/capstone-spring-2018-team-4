# Source: https://gist.github.com/henrik/276191

module I18n
  def self.name_for_locale(locale)
    self.with_locale(locale) { self.t('i18n.language.name', raise: true) }
    rescue I18n::MissingTranslationData
      locale.to_s
  end
end
