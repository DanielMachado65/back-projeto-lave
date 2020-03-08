require 'test_helper'

class EstablishmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @establishment = establishments(:one)
  end

  test "should get index" do
    get establishments_url, as: :json
    assert_response :success
  end

  test "should create establishment" do
    assert_difference('Establishment.count') do
      post establishments_url, params: { establishment: { address_id: @establishment.address_id, cnpj: @establishment.cnpj, fantasy_name: @establishment.fantasy_name, has_delivery: @establishment.has_delivery, name: @establishment.name, phone: @establishment.phone, user_id: @establishment.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show establishment" do
    get establishment_url(@establishment), as: :json
    assert_response :success
  end

  test "should update establishment" do
    patch establishment_url(@establishment), params: { establishment: { address_id: @establishment.address_id, cnpj: @establishment.cnpj, fantasy_name: @establishment.fantasy_name, has_delivery: @establishment.has_delivery, name: @establishment.name, phone: @establishment.phone, user_id: @establishment.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy establishment" do
    assert_difference('Establishment.count', -1) do
      delete establishment_url(@establishment), as: :json
    end

    assert_response 204
  end
end
