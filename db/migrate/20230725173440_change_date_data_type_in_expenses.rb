class ChangeDateDataTypeInExpenses < ActiveRecord::Migration[7.0]
  def change
    change_column :expenses, :date, :string
  end
end
