module Api
  # user service
  class V1::CategoryService
    def self.find(params)
      Category.find_by(id: params[:id]) if params[:id].present?
    end

    def self.create(attrs = {})
      params = category_params(attrs)
      return {code: 400, error: error} unless params.permitted?

      create_category(params)
    rescue StandardError => e
      {code: 400, error: e.message}
    end

    def self.update(category, attrs = {})
      params = category_params(attrs)
      return {code: 400, error: error} unless params.permitted?

      return category if update_category(category, params)

      {code: 400, error: 'update not possible'}
    rescue StandardError => e
      {code: 400, error: e.message}
    end

    private_class_method def self.category_params(params)
      params.require(:category).permit(:name)
    end

    private_class_method def self.create_category(attrs)
      @category = Category.create(attrs)
      return {code: 400, error: @category.errors.as_json} if @category.errors.present?

      @category
    end

    private_class_method def self.update_category(category, attrs)
      category.update(attrs)
    end
  end
end
