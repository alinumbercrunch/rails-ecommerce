class User::ProductsController < UserController
  before_action :authenticate_user!
  before_action :set_user_product, only: %i[ show edit update destroy ]

  # GET /user/products or /user/products.json
  def index
    @user_products = Product.all
  end

  # GET /user/products/1 or /user/products/1.json
  def show
  end

  # GET /user/products/new
  def new
    @user_product = Product.new
  end

  # GET /user/products/1/edit
  def edit
  end

  # POST /user/products or /user/products.json
  def create
    @user_product = Product.new(user_product_params)
    respond_to do |format|
      if @user_product.save
        format.html { redirect_to user_product_url(@user_product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @user_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user/products/1 or /user/products/1.json
  def update
    @user_product = Product.find(params[:id])
    if @user_product.update(user_product_params.reject {|k| k["images"] })
      if user_product_params["images"]
        user_product_params["images"].each do |image|
           @user_product.images.attach(image)
        end
      end
        redirect_to user_products_path, notice: "Product was successfully updated"
      else render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /user/products/1 or /user/products/1.json
  def destroy
    @user_product.destroy!

    respond_to do |format|
      format.html { redirect_to user_products_path, status: :see_other, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_product
      @user_product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_product_params
      params.require(:product).permit(:name, :description, :price, :category_id, :active, images: [])
    end
end
