class Employee < ApplicationRecord
    # has_many :expense_reports
    #has_many :expenses
    validates :name, presence: true
    validates :emp_id, presence: true, uniqueness: true, length: { is: 6 }
    validates :dept, presence: true
    validates :emp_status, inclusion: { in: %w(present terminated) }
end