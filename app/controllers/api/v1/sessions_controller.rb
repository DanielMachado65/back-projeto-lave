class Api::V1::SessionsController < Api::V1::ApiController

  before_action :set_user
  skip_before_action :verify_authenticity_token
  skip_before_action :require_auth_token, only: [:create], raise: false

  def login
    if @user
      allow_token_to_be_used_only_for(@user)
      api_success(@user.as_json(only: :auth_token))
    else
      api_unauthorized(error: 'Credenciais erradas, por favor tente novamente')
    end
  end

  def destroy
    logout
  end

  # ----------------------------- User

  protected

  def set_user
    # check if ambassador already login
    return @bearer_token unless bearer_token.nil?

    @errors = verify_params(params)
    return api_error(@errors) if @errors.present?

    @user = find_user(params)
  end

  private

  def find_user(params)
    return false if params[:user][:email].blank?

    @user = User.find_by(email: params[:user][:email])
    return false if @user.nil?

    @user.authenticate(params[:user][:password])
  end

  def verify_params(params)
    @errors = []
    return (@errors << 'A requisição não tem o objeto usuário') if params[:user].nil?

    verify_email_and_password(params)
    @errors
  end

  def verify_email_and_password(params)
    @error << 'Na requisição falta o email' if params[:user][:email].blank?
    @error << 'Na requisição falta o senha' if params[:user][:password].blank?
  end

  def allow_token_to_be_used_only_for(user)
    user.regenerate_token
  end

  def logout
    user = current_user
    return api_error('Não foi cadastrado') if user.nil?

    api_success('Foi deslogado com sucesso') if user.invalidate_token
  end
end
