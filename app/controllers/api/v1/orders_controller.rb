class Api::V1::OrdersController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token

  before_action :require_auth_token
  before_action :set_product, only: %I[show update destroy]

  def show
    @order.nil? ? api_not_found('não foi encontrado') : api_success(@order)
  end

  def create
    api_return_success(Api::V1::OrderService.create(current_user, params), true)
  end

  def update
    return api_error('não foi encontrado o produto') if @order.nil?

    api_return_success(Api::V1::OrderService.update(@order, params))
  end

  def destroy
    @order.nil? ? api_error('não pode ser excluido') : api_success(@order.destroy)
  end

  private

  def set_product
    @order = Api::V1::OrderService.find(params)
  end
end
