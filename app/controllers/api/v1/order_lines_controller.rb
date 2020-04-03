# frozen_string_literal: true

class Api::V1::OrderLinesController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token
  
  before_action :require_auth_token
  before_action :set_order_line, only: %I[destroy]

  def create
    api_return(Api::V1::OrderLineService.create(params), true)
  end

  def destroy
    if @order_line.nil?
      return api_error(error: 'objecto não foi encontrado')
    else
      return api_success(@order_line.destroy)
    end
  end

  private 

  def set_order_line
    @order_line = Api::V1::OrderLineService.find(params)
  end
end
