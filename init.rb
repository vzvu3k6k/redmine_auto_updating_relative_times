require_dependency 'auto_updating_relative_times/application_helper_patch'

Redmine::Plugin.register :auto_updating_relative_times do
  name 'Auto Updating Relative Times plugin'
  description 'Automatically updates relative timestamps using rmm5t/jquery-timeago'
  version '0.0.1'
  url 'https://github.com/vzvu3k6k/redmine_auto_updating_relative_times'
end
