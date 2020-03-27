require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url, as: :json
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: { order: { address_id: @order.address_id, deadline: @order.deadline, establishment_id: @order.establishment_id, order_hash: @order.order_hash, payment_type: @order.payment_type, total: @order.total, user_id: @order.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show order" do
    get order_url(@order), as: :json
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: { address_id: @order.address_id, deadline: @order.deadline, establishment_id: @order.establishment_id, order_hash: @order.order_hash, payment_type: @order.payment_type, total: @order.total, user_id: @order.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order), as: :json
    end

    assert_response 204
  end
end
