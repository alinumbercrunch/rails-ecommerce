class User::CategoriesController < UserController
  before_action :set_user_category, only: %i[ show edit update destroy ]

  # GET /user/categories or /user/categories.json
  def index
    @user_categories = Category.all
  end

  # GET /user/categories/1 or /user/categories/1.json
  def show
  end

  # GET /user/categories/new
  def new
    @user_category = Category.new
  end

  # GET /user/categories/1/edit
  def edit
    @user_category = Category.find(params[:id])
  end

  # POST /user/categories or /user/categories.json
  def create
    @user_category = Category.new(user_category_params)

    respond_to do |format|
      if @user_category.save
        format.html { redirect_to user_category_url(@user_category), notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @user_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user/categories/1 or /user/categories/1.json
  def update
    respond_to do |format|
      if @user_category.update(user_category_params)
        format.html { redirect_to user_category_url, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @user_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user/categories/1 or /user/categories/1.json
  def destroy
    @user_category.destroy!

    respond_to do |format|
      format.html { redirect_to user_categories_path, status: :see_other, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_category
      @user_category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_category_params
      params.require(:category).permit(:name, :description, :image)
    end
end
