class Api::V1::CategoriesController < Api::V1::ApiController

  skip_before_action :verify_authenticity_token

  before_action :require_auth_token, except: %I[create]
  before_action :set_category, only: %I[show update destroy]

  def index
    @categories = Category.all
  end

  def show
    api_error('ocorreu algum erro') if @category.nil?

    api_success(@category)
  end

  def create
    category = Api::V1::CategoryService.create(params)
    return api_bad_request(category[:error]) if category[:code] == 400

    api_created(category)
  end

  def update
    return api_error('não foi encontrado a categoria') if @category.nil?

    category = Api::V1::CategoryService.update(@category, params)
    return api_bad_request(category[:error]) if category[:code] == 400

    api_success(category)
  end

  def destroy
    return api_error('não pode ser excluido') if @category.nil?

    api_success(@category.destroy)
  end

  private
    def set_category
      @category = Api::V1::CategoryService.find(params)
    end
end
