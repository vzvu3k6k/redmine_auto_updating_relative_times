require 'octokit'
require 'shellwords'

JQUERY_TIMEAGO_VERSION = '1.6.3'.freeze

desc 'Install jquery-timeago to assets/javascripts/vendor'
task :install_jquery_timeago, [:version] do |_, args|
  args.with_defaults(version: JQUERY_TIMEAGO_VERSION)
  version = args.version.delete_prefix('v')
  remove_dir 'assets/javascripts/vendor/jquery-timeago', true

  # Requires GNU tar
  sh "curl --silent --show-error -L https://github.com/rmm5t/jquery-timeago/archive/v#{version}.tar.gz | tar xz -C assets/javascripts/vendor --transform 's!^jquery-timeago-#{version}/!jquery-timeago/!' --wildcards jquery-timeago-#{version}/{jquery.timeago.js,locales/*.js}"
end

desc 'Release to GitHub'
task :release_to_github do
  repo = `git remote get-url origin`.chomp.slice(%r{\Agit@github\.com:(.+?/.+?)\.git\z}, 1)
  tag = `git describe --exact-match --tags`.chomp
  abort "Can't find a tag" if tag.empty?
  release_file_path = "redmine_auto_updating_relative_times-#{tag}.tar.gz"
  sh "git push origin #{tag.shellescape}"
  sh 'git add -f assets'
  sh 'git commit -m tmp'
  sh "git archive HEAD --prefix auto_updating_relative_times/ -o #{release_file_path.shellescape}"
  sh 'git reset HEAD^'

  client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  release = client.create_release(repo, tag)
  client.upload_asset(release[:url], release_file_path)
end
