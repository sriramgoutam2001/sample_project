class ChangeStatusColumnTypeInUsers < ActiveRecord::Migration[7.0]
  def up
    # Convert "status" string values to integers based on your enum definition
    execute <<-SQL
      ALTER TABLE users
      ALTER COLUMN status TYPE integer
      USING CASE
        WHEN status = 'present' THEN 0
        WHEN status = 'terminated' THEN 1
        ELSE NULL
      END;
    SQL
  end

  def down
    # Convert integers back to strings
    execute <<-SQL
      ALTER TABLE users
      ALTER COLUMN status TYPE varchar
      USING CASE
        WHEN status = 0 THEN 'present'
        WHEN status = 1 THEN 'terminated'
        ELSE NULL
      END;
    SQL
  end
end