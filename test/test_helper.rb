# Load the Redmine helper
require File.expand_path(File.dirname(__FILE__) + '/../../../test/test_helper')

def assert_time_tags(tag_name, num)
  assert_select "#{tag_name}.timeago", num
end

def assert_js(locale)
  [
    'vendor/jquery-timeago/jquery.timeago.js',
    "vendor/jquery-timeago/locales/jquery.timeago.#{locale}.js",
    'timeago.js'
  ].each do |script|
    assert_select "script[src='/plugin_assets/auto_updating_relative_times/javascripts/#{script}']", 1
  end
end
