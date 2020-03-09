class Api::V1::EstablishmentsController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token

  before_action :require_auth_token
  before_action :set_establishment, only: %I[show update destroy]

  def index
    @establishment = Establishment.all
    @establishment.nil? ? api_error('ocorreu algum erro') : api_success(@establishment)
  end

  def show
    @establishment.nil? ? api_error('não foi encontrado') : api_success(@establishment)
  end

  def create
    establishment = Api::V1::EstablishmentService.create(params, current_user)
    return api_bad_request(establishment[:error]) if establishment[:code] == 400

    api_created(establishment)
  end

  def update
    return api_error('não foi encontrado o estabelecimento') if @establishment.nil?

    establishment = Api::V1::EstablishmentService.update(@establishment, params)
    return api_bad_request(establishment[:error]) if establishment[:code] == 400

    api_success(establishment)
  end

  def destroy
    @establishment.nil? ? api_error('não pode ser excluido') : api_success(@establishment.destroy)
  end

  private

  def set_establishment
    @establishment = Api::V1::EstablishmentService.find(params)
  end
end
