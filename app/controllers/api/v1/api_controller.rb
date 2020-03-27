# main controller
class Api::V1::ApiController < ActionController::Base
  # Login
  def require_auth_token
    authenticate_token || api_forbidden('Acesso negado')
  end

  def current_user
    @current_user ||= authenticate_token
  end

  def api_return_success(service, created=false)
    return api_bad_request(service[:error]) if service[:code] == 400

    created ? api_created(service) : api_success(service)
  end

  protected

  # --------------------------- login
  def authenticate_token
    bearer_token
    User.find_by(auth_token: @bearer_token) unless @bearer_token.nil?
  end

  def bearer_token
    pattern = /^Bearer /
    header = request.headers['Authorization']
    @bearer_token = header.gsub(pattern, '') if header && header.match(pattern)
  end

  # --------------------------- error
  def api_error(data = {})
    render json: data, status: :bad_request
  end

  def api_bad_request(data = {})
    render json: {error: data}, status: :not_acceptable
  end

  def api_not_found(data = {})
    render json: {error: data}, status: :not_found
  end

  def api_unauthorized(data = {})
    render json: data, status: :forbidden
  end

  def api_forbidden(data = {})
    render json: data, status: :unauthorized
  end

  # --------------------------- success
  def api_created(data = {})
    render json: data, status: :created
  end

  def api_success(data)
    render json: data, status: :ok
  end

  def api_no_content(data = {})
    render json: data, status: :no_content
  end
end