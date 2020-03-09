class Api::V1::ProductsController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token

  before_action :require_auth_token
  before_action :set_product, only: %I[show update destroy]

  def show
    @product.nil? ? api_error('não foi encontrado') : api_success(@product)
  end

  def create
    product = Api::V1::ProductService.create(params)
    return api_bad_request(product[:error]) if product[:code] == 400

    api_created(product)
  end

  def update
    return api_error('não foi encontrado o estabelecimento') if @product.nil?

    product = Api::V1::ProductService.update(@product, params)
    return api_bad_request(product[:error]) if product[:code] == 400

    api_success(product)
  end

  def destroy
    @product.nil? ? api_error('não pode ser excluido') : api_success(@product.destroy)
  end

  private

  def set_product
    @product = Api::V1::ProductService.find(params)
  end
end
