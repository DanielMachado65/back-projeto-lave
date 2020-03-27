class Api::V1::OrderStatusesController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token

  before_action :require_auth_token
  before_action :set_order_status, only: %I[show update destroy]

  def index
    api_success(OrderStatus.all)
  end

  def show
    @order_status.nil? ? api_not_found('não foi encontrado') : api_success(@order_status)
  end

  def create
    order_status = Api::V1::OrderStatusService.create(params)
    return api_bad_request(order_status[:error]) if order_status[:code] == 400

    api_created(order_status)
  end

  private

  def set_order_status
    @order_status = Api::V1::OrderStatusService.find(params)
  end
end
