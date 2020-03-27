require 'test_helper'

class OrderStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_status = order_statuses(:one)
  end

  test "should get index" do
    get order_statuses_url, as: :json
    assert_response :success
  end

  test "should create order_status" do
    assert_difference('OrderStatus.count') do
      post order_statuses_url, params: { order_status: { name: @order_status.name } }, as: :json
    end

    assert_response 201
  end

  test "should show order_status" do
    get order_status_url(@order_status), as: :json
    assert_response :success
  end

  test "should update order_status" do
    patch order_status_url(@order_status), params: { order_status: { name: @order_status.name } }, as: :json
    assert_response 200
  end

  test "should destroy order_status" do
    assert_difference('OrderStatus.count', -1) do
      delete order_status_url(@order_status), as: :json
    end

    assert_response 204
  end
end
