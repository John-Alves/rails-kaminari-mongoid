class PricesController < ApplicationController
  before_action :set_product
  before_action :set_ticket
  before_action :set_price, only: [:show, :edit, :update, :destroy]

  # GET /prices
  # GET /prices.json
  def index
    @prices = @ticket.prices
  end

  # GET /prices/1
  # GET /prices/1.json
  def show
  end

  # GET /prices/new
  def new
    @price = @ticket.prices.new
  end

  # GET /prices/1/edit
  def edit
  end

  # POST /prices
  # POST /prices.json
  def create
    @price = @ticket.prices.new(price_params)

    respond_to do |format|
      if @price.save
        format.html { redirect_to location_after_action, notice: 'Price was successfully created.' }
        format.json { render :show, status: :created, location: @price }
      else
        format.html { render :new }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prices/1
  # PATCH/PUT /prices/1.json
  def update
    respond_to do |format|
      if @price.update(price_params)
        format.html { redirect_to location_after_action, notice: 'Price was successfully updated.' }
        format.json { render :show, status: :ok, location: @price }
      else
        format.html { render :edit }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prices/1
  # DELETE /prices/1.json
  def destroy
    @price.destroy
    respond_to do |format|
      format.html { redirect_to prices_url, notice: 'Price was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def location_after_action
      product_ticket_prices_path(@product, @ticket)
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_ticket
      @ticket = @product.tickets.find(params[:ticket_id])
    end

    def set_price
      @price = @ticket.prices.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def price_params
      params.require(:price).permit(:discount_value, :value, :benefit_tier)
    end
end
