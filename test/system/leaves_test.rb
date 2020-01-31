require "application_system_test_case"

class LeavesTest < ApplicationSystemTestCase
  setup do
    @leafe = leaves(:one)
  end

  test "visiting the index" do
    visit leaves_url
    assert_selector "h1", text: "Leaves"
  end

  test "creating a Leave" do
    visit leaves_url
    click_on "New Leave"

    check "Approved" if @leafe.approved
    fill_in "Approved by", with: @leafe.approved_by
    fill_in "Employee", with: @leafe.employee_id
    fill_in "End", with: @leafe.end
    fill_in "Reason", with: @leafe.reason
    fill_in "Start", with: @leafe.start
    click_on "Create Leave"

    assert_text "Leave was successfully created"
    click_on "Back"
  end

  test "updating a Leave" do
    visit leaves_url
    click_on "Edit", match: :first

    check "Approved" if @leafe.approved
    fill_in "Approved by", with: @leafe.approved_by
    fill_in "Employee", with: @leafe.employee_id
    fill_in "End", with: @leafe.end
    fill_in "Reason", with: @leafe.reason
    fill_in "Start", with: @leafe.start
    click_on "Update Leave"

    assert_text "Leave was successfully updated"
    click_on "Back"
  end

  test "destroying a Leave" do
    visit leaves_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Leave was successfully destroyed"
  end
end
