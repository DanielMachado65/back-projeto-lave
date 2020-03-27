require 'test_helper'

class OrderLinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_line = order_lines(:one)
  end

  test "should get index" do
    get order_lines_url, as: :json
    assert_response :success
  end

  test "should create order_line" do
    assert_difference('OrderLine.count') do
      post order_lines_url, params: { order_line: { order_id: @order_line.order_id, product_id: @order_line.product_id } }, as: :json
    end

    assert_response 201
  end

  test "should show order_line" do
    get order_line_url(@order_line), as: :json
    assert_response :success
  end

  test "should update order_line" do
    patch order_line_url(@order_line), params: { order_line: { order_id: @order_line.order_id, product_id: @order_line.product_id } }, as: :json
    assert_response 200
  end

  test "should destroy order_line" do
    assert_difference('OrderLine.count', -1) do
      delete order_line_url(@order_line), as: :json
    end

    assert_response 204
  end
end
