class User::OrdersController < UserController
  before_action :authenticate_user!
  before_action :set_user_order, only: %i[ show edit update destroy ]

  # GET /user/orders or /user/orders.json
  def index
    @unfulfilled_orders = Order.where(fullfilled: false).order(created_at: :asc)
    @fulfilled_orders = Order.where(fullfilled: true).order(created_at: :asc)
  end
  # GET /user/orders/1 or /user/orders/1.json
  def show
  end

  # GET /user/orders/new
  def new
    @user_order = Order.new
  end

  # GET /user/orders/1/edit
  def edit
  end

  # POST /user/orders or /user/orders.json
  def create
    @user_order = current_user.orders.new(user_order_params)
    respond_to do |format|
      if @user_order.save
        format.html { redirect_to  user_order_url(@user_order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @user_order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user/orders/1 or /user/orders/1.json
  def update
    respond_to do |format|
      if @user_order.update(user_order_params)
        format.html { redirect_to user_order_url(@user_order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @user_order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user/orders/1 or /user/orders/1.json
  def destroy
    @user_order.destroy!

    respond_to do |format|
      format.html { redirect_to user_orders_path, status: :see_other, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_order
      @user_order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_order_params
      params.require(:order).permit(:customer_email, :fullfilled, :total, :address)
    end
end
