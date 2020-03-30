# frozen_string_literal: true

class Api::V1::OrderLinesController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token
  before_action :require_auth_token

  def create
    api_return_success(Api::V1::OrderLineService.create(params), true)
  end
end
