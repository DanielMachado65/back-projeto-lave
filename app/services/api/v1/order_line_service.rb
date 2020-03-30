# frozen_string_literal: true

module Api
  # user service
  class V1::OrderLineService
    def self.find(params)
      OrderLine.find_by(id: params[:id]) if params[:id].present?
    end

    def self.create(attrs)
      params = order_line_params(attrs)
      raise 'paramtros não permitidos' unless params.permitted?

      create_order_line(params)
    rescue StandardError => e
      { code: 400, error: e.message }
    end

    private_class_method def self.order_line_params(params)
      params.require(:order_line).permit(:order_id, :product_id)
    end

    private_class_method def self.create_order_line(attrs)
      order = find_order(attrs[:order_id])
      return { code: 400, error: 'não foi encontrado pedido' } if order.nil?

      product = find_order(attrs[:product_id])
      return { code: 400, error: 'não foi encontrado pedido' } if product.nil?

      @order.establishment = OrderLine.new(order: order, product: product)
      return @order if @order.save

      { code: 400, error: @order.errors.as_json }
    end

    private_class_method def self.find_order(order_id)
      Order.find_by(id: order_id)
    end

    private_class_method def self.find_product(product_id)
      Product.find_by(id: product_id)
    end
  end
end
