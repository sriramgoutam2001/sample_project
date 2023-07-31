class AddExpenseStatusToExpenses < ActiveRecord::Migration[7.0]
  def change
    add_column :expenses, :expense_status, :integer, default: 0, null: false
  end
end