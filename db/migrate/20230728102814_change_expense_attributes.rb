class ChangeExpenseAttributes < ActiveRecord::Migration[7.0]
  def change
    change_column :expenses, :amount, :float, using: 'amount::float'

    # Change 'date' column to date type
    change_column :expenses, :date, :date, using: 'date::date'

    # Add validation for 'invoice_number' column to allow only alphanumeric characters
    add_index :expenses, :invoice_number, unique: true
    execute <<-SQL
      UPDATE expenses SET invoice_number = regexp_replace(invoice_number, '[^a-zA-Z0-9]', '', 'g');
    SQL
  end
end
