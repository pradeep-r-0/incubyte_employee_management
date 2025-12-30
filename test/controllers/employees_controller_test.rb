require "test_helper"

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee = employees(:one)
    @employee_indian = Employee.create!(full_name: "Ram", job_title: "SDE", country: "India", salary: 300000)
    @employee_us = Employee.create!(full_name: "Laxman", job_title: "SDE", country: "India", salary: 500000)
  end

  test "should get index" do
    get employees_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_url
    assert_response :success
  end

  test "should create employee" do
    assert_difference("Employee.count") do
      post employees_url, params: { employee: { country: @employee.country, full_name: @employee.full_name, job_title: @employee.job_title, salary: @employee.salary } }
    end

    assert_redirected_to employee_url(Employee.last)
  end

  test "should show employee" do
    get employee_url(@employee)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_url(@employee)
    assert_response :success
  end

  test "should update employee" do
    patch employee_url(@employee), params: { employee: { country: @employee.country, full_name: @employee.full_name, job_title: @employee.job_title, salary: @employee.salary } }
    assert_redirected_to employee_url(@employee)
  end

  test "should destroy employee" do
    assert_difference("Employee.count", -1) do
      delete employee_url(@employee)
    end

    assert_redirected_to employees_url
  end

  test "min_max_salary_by_country response" do
    get min_max_salary_in_country_employees_path, params: { country: "India" }, as: :json

    assert_response :success
    json = JSON.parse(@response.body)

    assert json.key?("country")
    assert json.key?("min_salary")
    assert json.key?("max_salary")

    assert_equal "India", json["country"]
    assert_equal "300000.0", json["min_salary"]
    assert_equal "500000.0", json["max_salary"]
  end

  test "avg_salary_by_job_title response" do
    get avg_salary_by_job_title_employees_path, params: { job_title: "SDE" }, as: :json

    assert_response :success
    json = JSON.parse(@response.body)

    assert json.key?("job_title")
    assert json.key?("avg_salary")


    assert_equal "SDE", json["job_title"]
    assert_equal "400000.0", json["avg_salary"]
  end

  test "min_max_salary_by_country missing param returns error" do
    get min_max_salary_in_country_employees_path, as: :json
    assert_response :bad_request

    json = JSON.parse(@response.body)
    assert json.key?("error")
    assert_match /country/, json["error"]
  end

  test "avg_salary_by_job_title missing param returns error" do
    get avg_salary_by_job_title_employees_path, as: :json
    assert_response :bad_request

    json = JSON.parse(@response.body)
    assert json.key?("error")
    assert_match /job_title/, json["error"]
  end
end
