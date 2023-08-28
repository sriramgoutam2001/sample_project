class ExpenseReport < ApplicationRecord
    belongs_to :user
    has_many :expenses
    has_many :comments
end
