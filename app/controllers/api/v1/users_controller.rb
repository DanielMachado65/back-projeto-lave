# controller for user
class Api::V1::UsersController < Api::V1::ApiController

  skip_before_action :verify_authenticity_token
  before_action :require_auth_token, except: %I[create]

  def show
    current_user
  end

  def create
    if params[:user].present?
      user = Api::V1::UserService.create(params)
      return api_bad_request(user[:error]) if user[:code] == 400

      return api_created(user: user)
    end
    api_error('não foi possível realizarmos o cadastro por alguma exceção')
  end

  def update
    if params[:user].present?
      user = Api::V1::UserService.update(current_user, params)
      return api_bad_request(user[:error]) if user[:code] == 400

      return api_created(user: user)
    end
    api_error('não foi possível realizarmos o cadastro por alguma exceção')
  end

  def destroy
    current_user.destroy ? api_success(data: :ok) : api_error(data: :error)
  end
end