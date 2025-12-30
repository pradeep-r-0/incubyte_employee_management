require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  # Runs before every test
  setup do
    @employee = Employee.new(
      full_name: "Ramesh",
      job_title: "SDE",
      country: "India",
      salary: 100000
    )
  end

  test "should be valid with all attributes" do
    assert @employee.valid?
  end

  test "should require full_name" do
    @employee.full_name = nil
    assert_not @employee.valid?
    assert_includes @employee.errors[:full_name], "can't be blank"
  end

  test "should require job_title" do
    @employee.job_title = nil
    assert_not @employee.valid?
    assert_includes @employee.errors[:job_title], "can't be blank"
  end

  test "should require country" do
    @employee.country = nil
    assert_not @employee.valid?
    assert_includes @employee.errors[:country], "can't be blank"
  end

  test "should require salary" do
    @employee.salary = nil
    assert_not @employee.valid?
    assert_includes @employee.errors[:salary], "can't be blank"
  end

  test "should require salary to be a number >= 0" do
    @employee.salary = -100
    assert_not @employee.valid?
    assert_includes @employee.errors[:salary], "must be greater than or equal to 0"

    @employee.salary = "abc"
    assert_not @employee.valid?
    assert_includes @employee.errors[:salary], "is not a number"
  end

  test "should require unique full_name" do
    duplicate_employee = @employee.dup
    @employee.save!
    assert_not duplicate_employee.valid?
    assert_includes duplicate_employee.errors[:full_name], "has already been taken"
  end
end
