require 'rails_helper'

RSpec.describe User::CategoriesController, type: :controller do
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
      end

      it "adds a category" do
        category_params = FactoryBot.attributes_for(:category)
        sign_in @user
        expect {
          post :create, params: { category: category_params }
          puts response.body
        }.to change(@user.categories, :count).by(1)
      end
    end

    context "as a guest" do
      it "should return a status code 302 (redirecting)" do
        category_params = FactoryBot.attributes_for(:category)
        post :create, params: { category: category_params }
        expect(response).to have_http_status(:found)
      end

      it "redirects to the sign-in page" do
        category_params = FactoryBot.attributes_for(:category)
        post :create, params: { category: category_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "PUT #update" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        @category = FactoryBot.create(:category, user: @user)
      end

      it "updates a category" do
        category_params = FactoryBot.attributes_for(:category, name: "Updated category name")
        sign_in @user
        patch :update, params: { id: @category.id, category: category_params }
        expect(@category.reload.name).to eq "Updated category name"
      end
    end

    #  Unauthorized access is not implemented yet, need to use pundit or other gem later
    # context "as an unauthorized user" do
    #   before do
    #     @user = FactoryBot.create(:user)
    #     @other_user = FactoryBot.create(:user, email: "some_other_mail@gmail-test.com")
    #     @category = FactoryBot.create(:category, user: @other_user, name: "Same Old Name")
    #   end

    #   it "It does not update the category" do
    #     category_params = FactoryBot.attributes_for(:category, name: "Updated category name")
    #     sign_in @user
    #     patch :update, params: { id: @category.id, category: category_params }
    #     expect(@category.reload.name).to eq "Same Old Name"
    #   end

    #   it "redirects to the sign-in page" do
    #     category_params = FactoryBot.attributes_for(:category)
    #     patch :update, params: { id: @category.id, category: category_params }
    #     expect(response).to redirect_to new_user_session_path
    #   end
    # end

    context "as a guest" do
      before do
        @category = FactoryBot.create(:category)
      end

      it "should return a status code 302 (redirecting)" do
        category_params = FactoryBot.attributes_for(:category)
        patch :update, params: { id: @category.id, category: category_params }
        expect(response).to have_http_status(:found)
      end

      it "redirects to the sign-in page" do
        category_params = FactoryBot.attributes_for(:category)
        patch :update, params: { id: @category.id, category: category_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

   describe "DELETE #destroy" do
    context "as an authenticated user" do
       before do
        @user = FactoryBot.create(:user)
        @category = FactoryBot.create(:category, user: @user)
      end

      it "deletes a category" do
        sign_in @user
        expect {
          delete :destroy, params: { id:  @category.id }
          puts response.body
        }.to change(@user.categories, :count).by(-1)
      end
    end

    # context "as an unauthorized user" do
    #    before do
    #     @user = FactoryBot.create(:user)
    #     @other_user = FactoryBot.create(:user, email: "some_other_mail@gmail-test.com")
    #     @category = FactoryBot.create(:category, user: @other_user)
    #   end

    #   it "does not delete a category" do
    #     sign_in @user
    #     expect {
    #       delete :destroy, params: { id: @category.id }
    #       puts response.body
    #     }.to_not change(Category, :count)
    #   end

    #   it "redirects to the sign-in page" do
    #     sign_in @user
    #     delete :destroy, params: { id: @category.id }
    #     expect(response).to redirect_to new_user_session_path
    #   end
    # end

    context "as a guest" do
      before do
        @category = FactoryBot.create(:category)
      end

      it "should return a status code 302 (redirecting)" do
        delete :destroy, params: { id: @category.id }
        expect(response).to have_http_status(:found)
      end

      it "redirects to the sign-in page" do
        delete :destroy, params: { id: @category.id }
        expect(response).to redirect_to new_user_session_path
      end
      it "does not delete a category" do
        expect {
          delete :destroy, params: { id: @category.id }
          puts response.body
        }.to_not change(Category, :count)
      end
    end
  end
end
