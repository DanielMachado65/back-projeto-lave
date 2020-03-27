module Api
  # user service
  class V1::OrderStatusService
    def self.find(params)
      OrderStatus.find_by(id: params[:id]) if params[:id].present?
    end

    def self.create(attrs = {})
      params = category_params(attrs)
      return {code: 400, error: error} unless params.permitted?

      create_category(params)
    rescue StandardError => e
      {code: 400, error: e.message}
    end

    private_class_method def self.category_params(params)
      params.require(:order_status).permit(:name)
    end

    private_class_method def self.create_category(attrs)
      @order_status = OrderStatus.create(attrs)
      return {code: 400, error: @order_status.errors.as_json} if @order_status.errors.present?

      @order_status
    end
  end
end
