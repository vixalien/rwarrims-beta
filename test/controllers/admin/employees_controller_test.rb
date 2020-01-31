require 'test_helper'

class Admin::EmployeesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_employees_index_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_employees_destroy_url
    assert_response :success
  end

  test "should get show" do
    get admin_employees_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_employees_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_employees_update_url
    assert_response :success
  end

end
