module Api
  # user service
  class V1::ProductService
    def self.find(params)
      Product.find_by(id: params[:id]) if params[:id].present?
    end

    def self.create(attrs = {})
      params = product_params(attrs)
      return {code: 400, error: error} unless params.permitted?

      create_product(params)
    rescue Exception => error
      return {code: 400, error: error.message}
    end

    def self.update(product, attrs = {})
      params = product_params(attrs)
      return {code: 400, error: error} unless params.permitted?

      return product if update_product(product, params)

      {code: 400, error: 'update not possible'}
    rescue Exception => error
      return {code: 400, error: error.message}
    end

    private

    def self.product_params(params)
      params.require(:product).permit(:is_active, :price, :name,
                                      :description, :category, :establishment)
    end

    def self.create_product(attrs)
      @product = Product.create(attrs.except(:category, :establishment))
      return { code: 400, error: @product.errors.as_json} if @product.errors.present?

      @product
    end

    def self.update_product(category, attrs)
      category.update(attrs)
    end
  end
end
