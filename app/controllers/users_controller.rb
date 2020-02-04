# users controller
class UsersController < ApplicationController
  before_action :login, except: %i[create]

  def show
    render json: {msg: 'Seja bem-vindo'}, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.login.nil? || @user.password.nil?
      return api_bad_request('login and password required')
    end

    if @user.save
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :password)
  end
end
