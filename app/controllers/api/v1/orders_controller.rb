class Api::V1::OrdersController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token

  before_action :require_auth_token
  before_action :set_product, only: %I[show update destroy]

  def show
    @order.nil? ? api_not_found('não foi encontrado') : api_success(@order)
  end

  def create
    order = Api::V1::OrderService.create(params, current_user)
    return api_bad_request(order[:error]) if order[:code] == 400

    api_created(order)
  end

  def update
    return api_error('não foi encontrado o produto') if @order.nil?

    order = Api::V1::OrderService.update(@order, params)
    return api_bad_request(order[:error]) if order[:code] == 400

    api_success(order)
  end

  def destroy
    @order.nil? ? api_error('não pode ser excluido') : api_success(@order.destroy)
  end

  private

  def set_product
    @order = Api::V1::OrderService.find(params)
  end
end
