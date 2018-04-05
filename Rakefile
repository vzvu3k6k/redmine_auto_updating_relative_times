JQUERY_TIMEAGO_VERSION = '1.6.3'.freeze

desc 'Install jquery-timeago to assets/javascripts/vendor'
task :install_jquery_timeago, [:version] do |_, args|
  args.with_defaults(version: JQUERY_TIMEAGO_VERSION)
  version = args.version.delete_prefix('v')
  remove_dir 'assets/javascripts/vendor/jquery-timeago', true

  # Requires GNU tar
  sh "curl --silent --show-error -L https://github.com/rmm5t/jquery-timeago/archive/v#{version}.tar.gz | tar xz -C assets/javascripts/vendor --transform 's!^jquery-timeago-#{version}/!jquery-timeago/!' --wildcards jquery-timeago-#{version}/{jquery.timeago.js,locales/*.js}"
end
