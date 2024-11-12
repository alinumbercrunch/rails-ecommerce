require 'rails_helper'

RSpec.describe User::ProductsController, type: :controller do
  describe "GET #index" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "responds successfully" do
        sign_in @user
        get :index
        expect(response).to be_successful
      end

      it "should return status code ok 200" do
        sign_in @user
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    context "as a guest" do
      it "should return a status code 302 (redirecting)" do
        get :index
        expect(response).to have_http_status(:found) # or :redirect
      end
    end
  end

  describe "POST #create" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        @category = FactoryBot.create(:category, user: @user)
        @product = FactoryBot.create(:product, category: @category)
      end

      it "adds a product" do
        product_params = FactoryBot.attributes_for(:product, category: @category).merge(category_id: @category.id)
        sign_in @user
        expect {
          post :create, params: { product: product_params }
          puts response.body
        }.to change(@category.products, :count).by(1)
      end
    end

    context "as a guest" do
      it "should return a status code 302 (redirecting)" do
        product_params = FactoryBot.attributes_for(:product)
        post :create, params: { product: product_params }
        expect(response).to have_http_status(:found)
      end

      it "redirects to the sign-in page" do
        product_params = FactoryBot.attributes_for(:product)
        post :create, params: { product: product_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "PUT #update" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        @category = FactoryBot.create(:category, user: @user)
        @product = FactoryBot.create(:product, category: @category)
      end

      it "updates a product" do
        product_params = FactoryBot.attributes_for(:product, name: "Updated product name")
        sign_in @user
        patch :update, params: { id: @product.id, product: product_params }
        expect(@product.reload.name).to eq "Updated product name"
      end
    end

    #  Unauthorized access is not implemented yet, need to use pundit or other gem later
    # context "as an unauthorized user" do
    #   before do
    #     @user = FactoryBot.create(:user)
    #     @other_user = FactoryBot.create(:user, email: "some_other_mail@gmail-test.com")
    #     @product = FactoryBot.create(:product, user: @other_user, name: "Same Old Name")
    #   end

    #   it "It does not update the  product" do
    #      product_params = FactoryBot.attributes_for(:product, name: "Updated product name")
    #     sign_in @user
    #     patch :update, params: { id: @product.id, product: product_params }
    #     expect(@product.reload.name).to eq "Same Old Name"
    #   end

    #   it "redirects to the sign-in page" do
    #      product_params = FactoryBot.attributes_for(:product)
    #     patch :update, params: { id: @product.id, product: product_params }
    #     expect(response).to redirect_to new_user_session_path
    #   end
    # end

    context "as a guest" do
      before do
        @product = FactoryBot.create(:product)
      end

      it "should return a status code 302 (redirecting)" do
        product_params = FactoryBot.attributes_for(:product)
        patch :update, params: { id: @product.id, user_product: product_params }
        expect(response).to have_http_status(:found)
      end

      it "redirects to the sign-in page" do
        product_params = FactoryBot.attributes_for(:product)
        patch :update, params: { id: @product.id, user_product: product_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

   describe "DELETE #destroy" do
    context "as an authenticated user" do
       before do
        @user = FactoryBot.create(:user)
        @category = FactoryBot.create(:category, user: @user)
        @product = FactoryBot.create(:product, category: @category)
      end

      it "deletes a  product" do
        sign_in @user
        expect {
          delete :destroy, params: { id: @product.id }
          puts response.body
        }.to change(@category.products, :count).by(-1)
      end
    end

    # context "as an unauthorized user" do
    #    before do
    #     @user = FactoryBot.create(:user)
    #     @other_user = FactoryBot.create(:user, email: "some_other_mail@gmail-test.com")
    #     @product = FactoryBot.create(:product, user: @other_user)
    #   end

    #   it "does not delete a product" do
    #     sign_in @user
    #     expect {
    #       delete :destroy, params: { id: @product.id }
    #       puts response.body
    #     }.to_not change( product, :count)
    #   end

    #   it "redirects to the sign-in page" do
    #     sign_in @user
    #     delete :destroy, params: { id: @product.id }
    #     expect(response).to redirect_to new_user_session_path
    #   end
    # end

    context "as a guest" do
      before do
        @product = FactoryBot.create(:product)
      end

      it "should return a status code 302 (redirecting)" do
        delete :destroy, params: { id: @product.id }
        expect(response).to have_http_status(:found)
      end

      it "redirects to the sign-in page" do
        delete :destroy, params: { id: @product.id }
        expect(response).to redirect_to new_user_session_path
      end
      it "does not delete a product" do
        expect {
          delete :destroy, params: { id: @product.id }
          puts response.body
        }.to_not change( Product, :count)
      end
    end
  end

end
