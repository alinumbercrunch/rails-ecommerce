require 'rails_helper'


RSpec.describe User::StocksController, type: :controller do
  describe "GET #index" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user, email: "alip2259@test.com")
        @stock = FactoryBot.create(:stock)
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

      # it "responds with HTML formatted output" do
      #   sign_in @user
      #   get :show, params: { product_id: @stock.product.id }
      #   expect(response.content_type).to eq "text/html; charset=utf-8"
      # end
    end

    context "as a guest" do
      it "should return a status code 302 (redirecting)" do
        @stock = FactoryBot.create(:stock)
        get :index,  params: { product_id: @stock.product.id }
        expect(response).to have_http_status(:found) # or :redirect
      end
    end
  end
end
