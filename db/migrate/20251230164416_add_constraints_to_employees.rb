class AddConstraintsToEmployees < ActiveRecord::Migration[7.0]
  def change
    change_column_null :employees, :full_name, false
    change_column_null :employees, :job_title, false
    change_column_null :employees, :country, false
    change_column_null :employees, :salary, false

    add_index :employees, :full_name, unique: true


    add_index :employees, :job_title
    add_index :employees, :country
  end
end
