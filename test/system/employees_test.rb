require "application_system_test_case"

class EmployeesTest < ApplicationSystemTestCase
  setup do
    @employee = Employee.create!(
      full_name: "ExistingEmployee_#{SecureRandom.hex(3)}",
      job_title: "SDE",
      country: "India",
      salary: 300000
    )
  end

  test "visiting the index" do
    visit employees_url
    assert_selector "h1", text: "Employees"
  end

  test "should create employee" do
    visit employees_url
    click_on "New employee"

    fill_in "Country", with: @employee.country
    fill_in "Full name", with: @employee.full_name+"#{SecureRandom.hex(3)}"
    fill_in "Job title", with: @employee.job_title
    fill_in "Salary", with: @employee.salary
    click_on "Create Employee"

    assert_text "Employee was successfully created"
    click_on "Back"
  end

  test "should update Employee" do
    visit employee_url(@employee)
    click_on "Edit this employee", match: :first

    fill_in "Country", with: @employee.country
    fill_in "Full name", with: @employee.full_name
    fill_in "Job title", with: @employee.job_title
    fill_in "Salary", with: @employee.salary
    click_on "Update Employee"

    assert_text "Employee was successfully updated"
    click_on "Back"
  end

  test "should destroy Employee" do
    visit employee_url(@employee)
    click_on "Destroy this employee", match: :first

    assert_text "Employee was successfully destroyed"
  end
end
