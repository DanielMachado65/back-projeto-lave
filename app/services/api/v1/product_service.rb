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
    rescue StandardError => e
      {code: 400, error: e.message}
    end

    def self.update(product, attrs = {})
      params = product_params(attrs)
      return {code: 400, error: error} unless params.permitted?

      return product if update_product(product, params)

      {code: 400, error: 'update not possible'}
    rescue StandardError => e
      {code: 400, error: e.message}
    end

    private_class_method def self.product_params(params)
      params.require(:product).permit(:is_active, :price, :name,
                                      :description, :category, :establishment)
    end

    private_class_method def self.create_product(attrs)
      @product = Product.new(attrs.except(:category, :establishment))
      @product.category = Category.find_by(id: attrs[:category])
      @product.establishment = Establishment.find_by(id: attrs[:establishment])

      return @product if @product.save

      { code: 400, error: @product.errors.as_json}
    end

    private_class_method def self.update_product(category, attrs)
      category.update(attrs)
    end
  end
end
