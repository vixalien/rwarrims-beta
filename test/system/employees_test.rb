require "application_system_test_case"

class EmployeesTest < ApplicationSystemTestCase
  setup do
    @employee = employees(:one)
  end

  test "visiting the index" do
    visit employees_url
    assert_selector "h1", text: "Employees"
  end

  test "creating a Employee" do
    visit employees_url
    click_on "New Employee"

    check "Admin" if @employee.admin
    fill_in "Email", with: @employee.email
    fill_in "Idcard", with: @employee.idcard
    fill_in "Names", with: @employee.names
    fill_in "Password", with: @employee.password
    fill_in "Position", with: @employee.position
    click_on "Create Employee"

    assert_text "Employee was successfully created"
    click_on "Back"
  end

  test "updating a Employee" do
    visit employees_url
    click_on "Edit", match: :first

    check "Admin" if @employee.admin
    fill_in "Email", with: @employee.email
    fill_in "Idcard", with: @employee.idcard
    fill_in "Names", with: @employee.names
    fill_in "Password", with: @employee.password
    fill_in "Position", with: @employee.position
    click_on "Update Employee"

    assert_text "Employee was successfully updated"
    click_on "Back"
  end

  test "destroying a Employee" do
    visit employees_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Employee was successfully destroyed"
  end
end
