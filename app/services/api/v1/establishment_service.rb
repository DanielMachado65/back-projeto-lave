module Api
  # user service
  class V1::EstablishmentService
    def self.find(params)
      Establishment.find_by(id: params[:id]) if params[:id].present?
    end

    def self.create(attrs = {}, current_user=nil)
      params = establishment_params(attrs)
      return {code: 400, error: error} unless params.permitted?

      create_establishment(params, current_user)
    rescue Exception => error
      return {code: 400, error: error.message}
    end

    def self.update(establishment, attrs = {})
      params = establishment_params(attrs)
      return {code: 400, error: error} unless params.permitted?

      return establishment if update_establishment(establishment, params)

      {code: 400, error: 'update not possible'}
    rescue Exception => error
      return {code: 400, error: error.message}
    end

    private

    def self.establishment_params(params)
      params.require(:establishment).permit(:name, :cnpj, :phone,
                                            :fantasy_name, :has_delivery,
                                            address: [:zip_code, :street, :city, :number, :state, :country],
                                            user: [:name, :email, :telephone])
    end

    def self.create_establishment(attrs, user=nil)
      @establishment = Establishment.new(attrs.except(:address, :user))
      @establishment.create_address(attrs[:address]) if attrs[:address].present?
      @establishment.user = user

      # saving
      return @establishment if @establishment.save
      { code: 400, error: @establishment.errors.as_json}
    end

    def self.update_establishment(category, attrs)
      category.update(attrs)
    end
  end
end
