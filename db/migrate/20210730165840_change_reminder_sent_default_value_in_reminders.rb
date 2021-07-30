class ChangeReminderSentDefaultValueInReminders < ActiveRecord::Migration[6.0]
  def change
    change_column_default :reminders, :reminder_sent, "false"
  end
end
