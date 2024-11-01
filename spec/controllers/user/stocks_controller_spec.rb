require 'rails_helper'

RSpec.describe User::StocksController, type: :controller do
  describe "GET #index" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user, email: "alip2259@test.com")
        @product = FactoryBot.create(:product)
        @stock = FactoryBot.create(:stock, product: @product)
      end

      it "responds successfully" do
        sign_in @user
        get :index, params: { product_id: @stock.product.id }
        expect(response).to be_successful
      end

      it "should return status code ok 200" do
        sign_in @user
        get :index, params: { product_id: @stock.product.id }
        expect(response).to have_http_status(:ok)
      end

      it "responds with HTML formatted output" do
        sign_in @user
        get :show, params: { product_id: @product.id, id: @stock }
        expect(response.content_type).to eq "text/html; charset=utf-8"
      end

        it "adds a stock" do
        @stock_params = FactoryBot.attributes_for(:stock, stock: @stock)
        sign_in @user
        expect {
          post :create, params:{ product_id: @product.id, stock: @stock_params }
          puts response.body
        }.to change(@product.stocks, :count).by(1)
      end

      it "updates a product" do
        stock_params = FactoryBot.attributes_for(:stock, size: "XL")
        sign_in @user
        patch :update, params: { product_id: @product.id, id: @stock.id, stock: stock_params}
        expect(@stock.reload.size).to eq "XL"
      end

      it "deletes a stock" do
        sign_in @user
        expect {
          delete :destroy, params: { product_id: @product.id, id: @stock.id }
          puts response.body
        }.to change(@product.stocks, :count).by(-1)
      end
    end

    context "as a guest" do
       before do
          @user = FactoryBot.create(:user, email: "alip2259@test.com")
          @product = FactoryBot.create(:product)
          @stock = FactoryBot.create(:stock, product: @product)
        end
      it "should return a status code 302 (redirecting)" do
        get :index, params: { product_id: @stock.product.id }
        expect(response).to have_http_status(:found) # or :redirect
      end
       it "does not delete a stock" do
          expect {
          delete :destroy,params: { product_id: @product.id, id: @stock.id }
          puts response.body
        }.to_not change( Stock, :count)
      end
    end
  end
end
