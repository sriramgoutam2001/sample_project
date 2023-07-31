class RemoveNameFromExpenseReports < ActiveRecord::Migration[7.0]
  def change
    remove_column :expense_reports, :name, :string
  end
end
