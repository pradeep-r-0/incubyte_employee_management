class CreateEmployees < ActiveRecord::Migration[7.2]
  def change
    create_table :employees do |t|
      t.string :full_name
      t.string :job_title
      t.string :country
      t.decimal :salary

      t.timestamps
    end
  end
end
