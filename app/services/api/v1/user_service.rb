module Api
  # user service
  class V1::UserService
    def self.create(attrs = {})
      params = user_params(attrs)
      return {code: 400, error: error} unless params.permitted?

      create_user(params)
    end

    def self.update(user, attrs = {})
      params = user_params(attrs)
      return {code: 400, error: error} unless params.permitted?

      return user.as_json(only: :auth_token) if update_user(user, params)

      {code: 400, error: 'update not possible'}
    end


    private

    def self.user_params(params)
      params.require(:user).permit(:name, :email, :password, :cpf, :telephone, :rg)
    end

    def self.create_user(attrs)
      @user = User.create(attrs)
      return {code: 400, error: @user.errors.as_json} if @user.errors.present?

      @user.regenerate_token
      @user.as_json(only: :auth_token)
    end

    def self.update_user(user, attrs)
      user.update(attrs)
    end
  end
end
