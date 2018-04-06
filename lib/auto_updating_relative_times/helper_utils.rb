module AutoUpdadingRelativeTimes
  module HelperUtils
    module_function

    # TODO: cache existing locales
    def find_timeago_locale(locale)
      return nil unless locale.match?(/\A\w+(?:-\w+)?\z/)
      asset_path = "vendor/jquery-timeago/locales/jquery.timeago.#{locale}.js"
      full_path = File.expand_path("../../assets/javascripts/#{asset_path}", File.dirname(__FILE__))
      File.exist?(full_path) ? asset_path : nil
    end
  end
end
