require 'test_helper'

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get index_index_url
    assert_response :success
  end

  test "should get about" do
    get index_about_url
    assert_response :success
  end

  test "should get faq" do
    get index_faq_url
    assert_response :success
  end

  test "should get issue" do
    get index_issue_url
    assert_response :success
  end

  test "should get help" do
    get index_help_url
    assert_response :success
  end

end
