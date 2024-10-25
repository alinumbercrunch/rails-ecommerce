class User::StocksController < ApplicationController
  layout "user"
  before_action :set_user_stock, only: %i[ show edit update destroy ]

  # GET /user/stocks or /user/stocks.json
  def index
    @user_stocks = Stock.where(product_id: params[:product_id])
  end

  # GET /user/stocks/1 or /user/stocks/1.json
  def show
    @product = Product.find(params[:product_id])
    @user_stock = @product.stocks.find(params[:id])
  end

  # GET /user/stocks/new
  def new
    @product = Product.find(params[:product_id])
    @user_stock = Stock.new
  end

  # GET /user/stocks/1/edit
  def edit
    @product = Product.find(params[:product_id])
    @user_stock = Stock.find(params[:id])
  end

  # POST /user/stocks or /user/stocks.json
  def create
    @product = Product.find(params[:product_id])
    @user_stock = @product.stocks.new(user_stock_params)

    respond_to do |format|
      if @user_stock.save
        format.html { redirect_to user_product_stock_url(@product, @user_stock), notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @user_stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user/stocks/1 or /user/stocks/1.json
  def update
    respond_to do |format|
      if @user_stock.update(user_stock_params)
        format.html { redirect_to user_product_stock_url, notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @user_stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user/stocks/1 or /user/stocks/1.json
  def destroy
    @user_stock.destroy!

    respond_to do |format|
      format.html { redirect_to user_product_stocks_path, status: :see_other, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_stock
      @user_stock = Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_stock_params
      params.require(:stock).permit(:product_id, :amount, :size)
    end
end
