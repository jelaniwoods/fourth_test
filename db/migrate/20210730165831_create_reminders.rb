class CreateReminders < ActiveRecord::Migration[6.0]
  def change
    create_table :reminders do |t|
      t.string :title
      t.datetime :remind_at
      t.boolean :reminder_sent
      t.integer :user_id

      t.timestamps
    end
  end
end
