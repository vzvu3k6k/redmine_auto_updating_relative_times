module AutoUpdadingRelativeTimes
  module ApplicationHelperPatch
    def time_tag(time)
      text = distance_of_time_in_words(Time.zone.now, time)
      tag =
        if @project
          content = content_tag('time', text, datetime: format_time(time), class: 'timeago')
          link_to(content, project_activity_path(@project, from: User.current.time_to_date(time)), title: format_time(time))
        else
          content_tag('abbr', text, title: format_time(time), class: 'timeago')
        end
      append_timeago_javascripts(tag)
    end

    def append_timeago_javascripts(tag)
      return tag if defined?(@auto_updating_relative_times_js)
      @auto_updating_relative_times_js = true
      [
        'vendor/jquery-timeago/jquery.timeago.js',
        "vendor/jquery-timeago/locales/jquery.timeago.#{current_language}.js",
        'timeago.js'
      ].each do |path|
        tag << javascript_include_tag(path, plugin: :auto_updating_relative_times)
      end
      tag
    end
  end

  ActionDispatch::Reloader.to_prepare do
    ApplicationHelper.send(:prepend, ApplicationHelperPatch) unless ApplicationHelper.include?(ApplicationHelperPatch)
  end
end
