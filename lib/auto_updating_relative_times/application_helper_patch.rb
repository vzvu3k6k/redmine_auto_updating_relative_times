require_dependency 'auto_updating_relative_times/helper_utils'

module AutoUpdadingRelativeTimes
  module ApplicationHelperPatch
    def time_tag(time)
      return super if AutoUpdadingRelativeTimes::HelperUtils.supports_locale?(current_language)
      time_tag_content(time, @project).concat(timeago_javascripts)
    end

    def time_tag_content(time, project = nil)
      text = distance_of_time_in_words(Time.zone.now, time)
      if project
        content = content_tag('time', text, datetime: format_time(time), class: 'timeago')
        link_to(content, project_activity_path(project, from: User.current.time_to_date(time)), title: format_time(time))
      else
        content_tag('abbr', text, title: format_time(time), class: 'timeago')
      end
    end

    def timeago_javascripts
      return if defined?(@auto_updating_relative_times_js_rendered)
      @auto_updating_relative_times_js_rendered = true

      [
        'vendor/jquery-timeago/jquery.timeago.js',
        "vendor/jquery-timeago/locales/jquery.timeago.#{current_language}.js",
        'timeago.js'
      ].reduce(ActiveSupport::SafeBuffer.new) { |tag, path|
        tag << javascript_include_tag(path, plugin: :auto_updating_relative_times)
      }
    end
  end

  ActionDispatch::Reloader.to_prepare do
    ApplicationHelper.send(:prepend, ApplicationHelperPatch) unless ApplicationHelper.include?(ApplicationHelperPatch)
  end
end
