class Api::V1::RemindersController < Api::V1::GraphitiController
  def index
    reminders = ReminderResource.all(params)
    respond_with(reminders)
  end

  def show
    reminder = ReminderResource.find(params)
    respond_with(reminder)
  end

  def create
    reminder = ReminderResource.build(params)

    if reminder.save
      render jsonapi: reminder, status: :created
    else
      render jsonapi_errors: reminder
    end
  end

  def update
    reminder = ReminderResource.find(params)

    if reminder.update_attributes
      render jsonapi: reminder
    else
      render jsonapi_errors: reminder
    end
  end

  def destroy
    reminder = ReminderResource.find(params)

    if reminder.destroy
      render jsonapi: { meta: {} }, status: :ok
    else
      render jsonapi_errors: reminder
    end
  end
end
