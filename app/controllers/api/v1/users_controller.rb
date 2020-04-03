# controller for user
class Api::V1::UsersController < Api::V1::ApiController

  skip_before_action :verify_authenticity_token
  before_action :require_auth_token, except: %I[create]
  before_action :set_user, only: %I[show update destroy]

  def show
    api_success(current_user)
  end

  def create
    api_return(Api::V1::UserService.update(current_user, params), true)
  end

  def update
    api_return(Api::V1::UserService.update(current_user, params))
  end

  def address
    api_return(Api::V1::UserService.update_address(current_user, params))
  end

  def destroy
    current_user.destroy ? api_success(data: :ok) : api_error(data: :error)
  end

  private

  def set_user
    return api_error('não foi encontrado usuário') if current_user.nil?
  end
end
