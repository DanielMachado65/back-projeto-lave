module Api
  # user service
  class V1::OrderService
    def self.find(params)
      Order.find_by(id: params[:id]) if params[:id].present?
    end

    def self.create(user, attrs)
      params = order_params(attrs)
      raise 'paramtros não permitidos' unless params.permitted?

      create_product(user, params)
    rescue StandardError => e
      { code: 400, error: e.message }
    end

    def self.update(order, attrs = {})
      params = order_params(attrs)
      raise 'paramtros não permitidos' unless params.permitted?

      return order if update_product(order, params)

      raise 'update not possible'
    rescue StandardError => e
      { code: 400, error: e.message }
    end

    private_class_method def self.order_params(params)
      params.require(:order).permit(:deadline, :total,
                                    :payment_type, :establishment)
    end

    private_class_method def self.create_product(user, attrs)
      @order = Order.new(attrs.except(:establishment))

      @order.user = user
      @order.address = user.address
      @order.establishment = Establishment.find_by(id: attrs[:establishment])

      return @order if @order.save

      { code: 400, error: @order.errors.as_json}
    end

    private_class_method def self.update_product(category, attrs)
      category.update(attrs)
    end
  end
end
