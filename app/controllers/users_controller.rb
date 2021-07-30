class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[me]

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @reminder = Reminder.new
  end

  def me
    jwt_payload = JWT.decode(
      request.headers['Authorization'].split(' ')[1],
      Rails.application.secret_key_base
    ).first
    @user = User.find(jwt_payload.fetch("id"))
    render "users/sessions/me"
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: "User was successfully created."
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: "User was successfully destroyed."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.fetch(:user, {})
  end
end
