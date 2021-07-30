class RemindersController < ApplicationController
  before_action :current_user_must_be_reminder_user,
                only: %i[edit update destroy]

  before_action :set_reminder, only: %i[show edit update destroy]

  def index
    @q = Reminder.ransack(params[:q])
    @reminders = @q.result(distinct: true).includes(:user).page(params[:page]).per(10)
  end

  def show; end

  def new
    @reminder = Reminder.new
  end

  def edit; end

  def create
    @reminder = Reminder.new(reminder_params)

    if @reminder.save
      message = "Reminder was successfully created."
      if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
        redirect_back fallback_location: request.referer, notice: message
      else
        redirect_to @reminder, notice: message
      end
    else
      render :new
    end
  end

  def update
    if @reminder.update(reminder_params)
      redirect_to @reminder, notice: "Reminder was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @reminder.destroy
    message = "Reminder was successfully deleted."
    if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
      redirect_back fallback_location: request.referer, notice: message
    else
      redirect_to reminders_url, notice: message
    end
  end

  private

  def current_user_must_be_reminder_user
    set_reminder
    unless current_user == @reminder.user
      redirect_back fallback_location: root_path,
                    alert: "You are not authorized for that."
    end
  end

  def set_reminder
    @reminder = Reminder.find(params[:id])
  end

  def reminder_params
    params.require(:reminder).permit(:title, :remind_at, :reminder_sent,
                                     :user_id)
  end
end
