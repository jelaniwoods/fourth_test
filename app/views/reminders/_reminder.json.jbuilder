json.extract! reminder, :id, :title, :remind_at, :reminder_sent, :user_id,
              :created_at, :updated_at
json.url reminder_url(reminder, format: :json)
