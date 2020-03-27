module Api
  # user service
  class V1::UserService
    def self.create(attrs = {})
      params = user_params(attrs)
      raise 'paramtros não permitidos' unless params.permitted?

      create_user(params)
    rescue StandardError => e
      { code: 400, error: e.message }
    end

    def self.update(user, attrs = {})
      params = user_params(attrs)
      raise 'paramtros não permitidos' unless params.permitted?

      return user if update_user(user, params)

      { code: 400, error: 'update not possible' }
    rescue StandardError => e
      { code: 400, error: e.message }
    end

    def self.update_address(user, attrs)
      unless attrs.require(:user).permit(address: {}).permitted?
        raise 'parametros não permitidos'
      end

      address = Api::V1::AddressService.create(attrs[:user])
      raise address[:error] if address[:code] == 400

      user.update(address: address)
      user
    rescue StandardError => e
      { code: 400, error: e.message }
    end

    private_class_method def self.user_params(params)
      params.require(:user).permit(:name, :email, :password,
                                   :cpf, :telephone, :rg)
    end

    private_class_method def self.create_user(attrs)
      @user = User.create(attrs)
      return { code: 400, error: @user.errors.as_json } if @user.errors.present?

      @user.regenerate_token ? @user : { code: 400, error: 'auth token error' }
    end

    private_class_method def self.update_user(user, attrs)
      user.update(attrs)
    end

    private_class_method def self.find_address(id)
      Address.find_by(id: id)
    end
  end
end
