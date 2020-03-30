# frozen_string_literal: true

module Api
  # user service
  class V1::AddressService
    def self.find(params)
      Address.find_by(id: params[:id]) if params[:id].present?
    end

    def self.create(attrs)
      params = address_params(attrs)
      raise 'paramtros não permitidos' unless params.permitted?

      create_address(params)
    rescue StandardError => e
      { code: 400, error: e.message }
    end

    def self.update(address, attrs = {})
      params = address_params(attrs)
      raise 'paramtros não permitidos' unless params.permitted?

      return address if update_address(address, params)

      raise 'update not possible'
    rescue StandardError => e
      { code: 400, error: e.message }
    end

    private_class_method def self.address_params(params)
      params.require(:address).permit(:zip_code, :street, :number, :city, :state, :country)
    end

    private_class_method def self.create_address(attrs)
      @address = Address.create(attrs)
      if @address.errors.present?
        return { code: 400, error: @address.errors.as_json }
      end

      @address
    end

    private_class_method def self.update_address(category, attrs)
      category.update(attrs)
    end
  end
end
