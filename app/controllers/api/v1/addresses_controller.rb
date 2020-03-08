class Api::V1::AddressesController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token

  before_action :require_auth_token, except: %I[create]
  before_action :set_address, only: %I[show update destroy]

  def index
    @address = Address.all
  end

  def show
    @address.nil? ? api_error('ocorreu algum erro') : api_success(@address)
  end

  def create
    address = Api::V1::AddressService.create(params)
    return api_bad_request(address[:error]) if address[:code] == 400

    api_created(address)
  end

  def update
    return api_error('não foi encontrado o endereço') if @address.nil?

    address = Api::V1::AddressService.update(@address, params)
    return api_bad_request(address[:error]) if address[:code] == 400

    api_success(address)
  end

  def destroy
    @address.nil? ? api_error('não pode ser excluido') : api_success(@address.destroy)
  end

  private

  def set_address
    @address = Api::V1::AddressService.find(params)
  end
end
