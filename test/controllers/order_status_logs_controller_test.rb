require 'test_helper'

class OrderStatusLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_status_log = order_status_logs(:one)
  end

  test "should get index" do
    get order_status_logs_url, as: :json
    assert_response :success
  end

  test "should create order_status_log" do
    assert_difference('OrderStatusLog.count') do
      post order_status_logs_url, params: { order_status_log: { order_id: @order_status_log.order_id, order_status_id: @order_status_log.order_status_id } }, as: :json
    end

    assert_response 201
  end

  test "should show order_status_log" do
    get order_status_log_url(@order_status_log), as: :json
    assert_response :success
  end

  test "should update order_status_log" do
    patch order_status_log_url(@order_status_log), params: { order_status_log: { order_id: @order_status_log.order_id, order_status_id: @order_status_log.order_status_id } }, as: :json
    assert_response 200
  end

  test "should destroy order_status_log" do
    assert_difference('OrderStatusLog.count', -1) do
      delete order_status_log_url(@order_status_log), as: :json
    end

    assert_response 204
  end
end
