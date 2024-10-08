require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe "#index" do
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

      it "redirects to the sign-in page" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
