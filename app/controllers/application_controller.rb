class ApplicationController < ActionController::API
  respond_to? :json

  def login
    # binding.pry
    login_user || api_forbidden('access denied')
  end

  def login_user
    return api_unauthorized('request not found params') unless login_params

    @user = User.login(params[:email], params[:password])
  end

  def login_params
    params[:email].present? && params[:password].present? ? true : false
  end

  def api_success(data = {})
    @api_response = {data: data}
    render json: @api_response, status: :ok
  end

  def api_unauthorized(data = {})
    @api_response = {data: data}
    render json: @api_response, status: :forbidden
  end

  def api_forbidden(data = {})
    @api_response = {data: data}
    render json: @api_response, status: :unauthorized
  end

  def api_bad_request(data = {})
    @api_response = {data: data}
    render json: @api_response, status: :not_acceptable
  end
end
