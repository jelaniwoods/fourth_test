class ReminderResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :title, :string
  attribute :remind_at, :datetime
  attribute :reminder_sent, :boolean
  attribute :user_id, :integer

  # Direct associations

  belongs_to :user

  # Indirect associations
end
