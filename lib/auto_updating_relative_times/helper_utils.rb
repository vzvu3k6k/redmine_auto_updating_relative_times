module AutoUpdadingRelativeTimes
  module HelperUtils
    module_function

    TIMEAGO_LOCALES = Dir.entries(
      File.expand_path('../../assets/javascripts/vendor/jquery-timeago/locales', __dir__)
    ).map { |entry| entry[/\Ajquery\.timeago\.(\w+(?:-\w+)?)\.js\z/, 1] }

    def supports_locale?(locale)
      TIMEAGO_LOCALES.include?(locale)
    end
  end
end
