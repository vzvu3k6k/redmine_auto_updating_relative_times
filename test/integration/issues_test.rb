require File.expand_path('../test_helper', File.dirname(__FILE__))

class IssuesTest < Redmine::IntegrationTest
  fixtures :projects,
           :users, :email_addresses,
           :roles,
           :members,
           :member_roles,
           :trackers,
           :projects_trackers,
           :enabled_modules,
           :issue_statuses,
           :issues,
           :enumerations,
           :custom_fields,
           :custom_values,
           :custom_fields_trackers,
           :attachments

  def test_issue_page_should_include_timeago_scripts
    log_user('jsmith', 'jsmith') # language: en

    get '/issues/1'
    assert_response :success
    assert_time_tags 'time', 2
    assert_js 'en'
  end

  def test_issue_page_should_include_timeago_scripts_of_users_locale
    log_user('miscuser8', 'foo') # language: it

    get '/issues/1'
    assert_response :success
    assert_time_tags 'time', 2
    assert_js 'it'
  end
end
