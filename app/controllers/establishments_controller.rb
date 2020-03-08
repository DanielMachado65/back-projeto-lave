class EstablishmentsController < ApplicationController
  before_action :set_establishment, only: [:show, :update, :destroy]

  # GET /establishments
  # GET /establishments.json
  def index
    @establishments = Establishment.all
  end

  # GET /establishments/1
  # GET /establishments/1.json
  def show
  end

  # POST /establishments
  # POST /establishments.json
  def create
    @establishment = Establishment.new(establishment_params)

    if @establishment.save
      render :show, status: :created, location: @establishment
    else
      render json: @establishment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /establishments/1
  # PATCH/PUT /establishments/1.json
  def update
    if @establishment.update(establishment_params)
      render :show, status: :ok, location: @establishment
    else
      render json: @establishment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /establishments/1
  # DELETE /establishments/1.json
  def destroy
    @establishment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_establishment
      @establishment = Establishment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def establishment_params
      params.require(:establishment).permit(:address_id, :user_id, :name, :cnpj, :phone, :fantasy_name, :has_delivery)
    end
end
