class Expense < ApplicationRecord
    #belongs_to :employee
    enum expense_status: {
      pending: 0,
      approved: 1,
      rejected: 2
    }
    has_one_attached :bill
    belongs_to :user
    has_many :comments, dependent: :destroy
    belongs_to :expense_report, optional: true

   # belongs_to :expense_report, optional: true
    validates :amount, presence: true
    validates :date, presence: true
    validates :description, presence: true
    validates :invoice_number, presence: true
  end