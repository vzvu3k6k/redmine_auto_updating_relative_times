require File.expand_path('../test_helper', File.dirname(__FILE__))

class NewsTest < Redmine::IntegrationTest
  fixtures :projects,
           :users, :email_addresses,
           :roles,
           :members,
           :member_roles,
           :enabled_modules,
           :news

  def test_news_page_should_include_timeago_scripts
    log_user('jsmith', 'jsmith') # language: en

    get '/news'
    assert_response :success
    assert_time_tags 'abbr', 3
    assert_js 'en'
  end

  def test_news_page_should_include_timeago_scripts_of_users_locale
    log_user('miscuser8', 'foo') # language: it

    get '/news'
    assert_response :success
    assert_time_tags 'abbr', 3
    assert_js 'it'
  end
end
