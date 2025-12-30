class Employee < ApplicationRecord
  validates :full_name, presence: true, uniqueness: true
  validates :job_title, :country, :salary, presence: true
  validates :salary, numericality: { greater_than_or_equal_to: 0 }
end
