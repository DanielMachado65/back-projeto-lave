class OrderLinesController < ApplicationController
  before_action :set_order_line, only: [:show, :update, :destroy]

  # GET /order_lines
  # GET /order_lines.json
  def index
    @order_lines = OrderLine.all
  end

  # GET /order_lines/1
  # GET /order_lines/1.json
  def show
  end

  # POST /order_lines
  # POST /order_lines.json
  def create
    @order_line = OrderLine.new(order_line_params)

    if @order_line.save
      render :show, status: :created, location: @order_line
    else
      render json: @order_line.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /order_lines/1
  # PATCH/PUT /order_lines/1.json
  def update
    if @order_line.update(order_line_params)
      render :show, status: :ok, location: @order_line
    else
      render json: @order_line.errors, status: :unprocessable_entity
    end
  end

  # DELETE /order_lines/1
  # DELETE /order_lines/1.json
  def destroy
    @order_line.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_line
      @order_line = OrderLine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_line_params
      params.require(:order_line).permit(:product_id, :order_id)
    end
end
