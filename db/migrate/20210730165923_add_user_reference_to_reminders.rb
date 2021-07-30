class AddUserReferenceToReminders < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :reminders, :users
    add_index :reminders, :user_id
    change_column_null :reminders, :user_id, false
  end
end
