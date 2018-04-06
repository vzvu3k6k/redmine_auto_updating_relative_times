require_dependency 'auto_updating_relative_times/helper_utils'

module AutoUpdadingRelativeTimes
  module ApplicationHelperPatch
    def time_tag(time)
      timeago_locale_path = AutoUpdadingRelativeTimes::HelperUtils.find_timeago_locale(current_language)
      return super if timeago_locale_path.blank?

      content = time_tag_content(time, @project)
      js_tag = timeago_javascripts(timeago_locale_path)
      content.concat(js_tag)
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

    def timeago_javascripts(timeago_locale_path)
      tag = ActiveSupport::SafeBuffer.new
      return tag if defined?(@auto_updating_relative_times_js)
      @auto_updating_relative_times_js = true

      [
        'vendor/jquery-timeago/jquery.timeago.js',
        timeago_locale_path,
        'timeago.js'
      ].each { |path| tag << javascript_include_tag(path, plugin: :auto_updating_relative_times) }
      tag
    end
  end

  ActionDispatch::Reloader.to_prepare do
    ApplicationHelper.send(:prepend, ApplicationHelperPatch) unless ApplicationHelper.include?(ApplicationHelperPatch)
  end
end
