require "rails_helper"

RSpec.describe TweetsController, type: :controller do
  let(:user)  { create(:user) }
  let(:tweet) { create(:tweet, user: user) }

  describe "GET #new" do
    it "requires login" do
      sign_out user
      get :new
      expect(response).to have_http_status(:found)
    end

    it "returns http status 302" do
      sign_in user
      get :new
      expect(response).to have_http_status(:ok)
    end

    it "assigns a new tweet to an instance variable" do
      sign_in user
      get :new
      expect(assigns(:tweet)).to be_a_new(Tweet)
    end

    it "render new template" do
      sign_in user
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "requires login" do
      sign_out user
      get :edit, params: { id: tweet.id }
      expect(response).to have_http_status(:found)
    end

    it "returns http status 302" do
      sign_in user
      get :edit, params: { id: tweet.id }
      expect(response).to have_http_status(:ok)
    end

    it "assigns the requested tweet to an instance variable" do
      sign_in user
      get :edit, params: { id: tweet.id }
      expect(assigns(:tweet)).to eq(tweet)
    end

    it "render edit template" do
      sign_in user
      get :edit, params: { id: tweet.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    it "requires login" do
      sign_out user
      post :create, params: { tweet: { message: "Demo Text" }}
      expect(response).to have_http_status(:found)
    end

    context "with valid attributes" do
      it "saves the new tweet in the database" do
        sign_in user
        expect {
          post :create, params: { tweet: { message: "Demo Text" }}
        }.to change(Tweet, :count).by(1)
      end

      it "returns http status 302" do
        sign_in user
        post :create, params: { tweet: { message: "Demo Text" }}
        expect(response).to have_http_status(:found)
      end

      it "assigns a newly created but unsaved tweet to an instance variable" do
        sign_in user
        post :create, params: { tweet: { message: "Demo Text" }}
        expect(assigns(:tweet)).to be_a(Tweet)
        expect(assigns(:tweet)).to be_persisted
      end

      it "have success flash message" do
        sign_in user
        post :create, params: { tweet: { message: "Demo Text" }}
        expect(flash[:success]).to eq(I18n.t("flash_messages.created", name: "Tweet"))
      end

      it "redirects to home page" do
        sign_in user
        post :create, params: { tweet: { message: "Demo Text" }}
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid attributes" do
      it "does not save the new tweet in the database" do
        sign_in user
        expect{
          post :create, params: { tweet: { message: "" }}
        }.not_to change(Tweet, :count)
      end

      it "assigns a newly created but unsaved tweet an instance variable" do
        sign_in user
        post :create, params: { tweet: { message: "" }}
        expect(assigns(:tweet)).to be_a_new(Tweet)
      end

      it "returns http status 302" do
        sign_in user
        post :create, params: { tweet: { message: "" }}
        expect(response).to have_http_status(:ok)
      end

      it "re-renders the :new template" do
        sign_in user
        post :create, params: { tweet: { message: "" }}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    it "requires login" do
      sign_out user
      patch :update, params: { id: tweet.id, tweet: { message: "Demo Text" }}
      expect(response).to have_http_status(:found)
    end

    context "with valid attributes" do
      it "updates the requested tweet" do
        sign_in user
        patch :update, params: { id: tweet.id, tweet: { message: "Demo Text" }}
        tweet.reload
        expect(tweet.message).to eq("Demo Text")
      end

      it "returns http status 302" do
        sign_in user
        patch :update, params: { id: tweet.id, tweet: { message: "Demo Text" }}
        expect(response).to have_http_status(:found)
      end

      it "assigns the requested tweet to an instance variable" do
        sign_in user
        patch :update, params: { id: tweet.id, tweet: { message: "Demo Text" }}
        expect(assigns(:tweet)).to eq(tweet)
      end

      it "have success flash message" do
        sign_in user
        patch :update, params: { id: tweet.id, tweet: { message: "Demo Text" }}
        expect(flash[:success]).to eq(I18n.t("flash_messages.updated", name: "Tweet"))
      end

      it "redirects to home page" do
        sign_in user
        patch :update, params: { id: tweet.id, tweet: { message: "Demo Text" }}
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid attributes" do
      it "does not update the requested tweet" do
        sign_in user
        expect {
          patch :update, params: { id: tweet.id, tweet: { message: "" }}
        }.not_to change { tweet.reload.attributes }
      end

      it "assigns the tweet to an instance variable" do
        sign_in user
        patch :update, params: { id: tweet.id, tweet: { message: "" }}
        expect(assigns(:tweet)).to eq(tweet)
      end

      it "returns http status 302" do
        sign_in user
        patch :update, params: { id: tweet.id, tweet: { message: "" }}
        expect(response).to have_http_status(:ok)
      end

      it "re-renders the :edit template" do
        sign_in user
        patch :update, params: { id: tweet.id, tweet: { message: "" }}
        expect(response).to render_template(:edit)
      end
    end
  end


  describe "DELETE #destroy" do
    it "requires login" do
      sign_out user
      delete :destroy, params: { id: tweet.id }
      expect(response).to have_http_status(:found)
    end

    it "delete the requested tweet" do
      sign_in user
      delete :destroy, params: { id: tweet.id }
      expect(Tweet.find_by(id: tweet.id)).to eq(nil)
    end

    it "returns http status 302" do
      sign_in user
      delete :destroy, params: { id: tweet.id }
      expect(response).to have_http_status(:found)
    end

    it "assigns the requested tweet to an instance variable" do
      sign_in user
      delete :destroy, params: { id: tweet.id }
      expect(assigns(:tweet)).to eq(tweet)
    end

    it "have danger flash message" do
      sign_in user
      delete :destroy, params: { id: tweet.id }
      expect(flash[:danger]).to eq(I18n.t("flash_messages.deleted", name: "Tweet"))
    end

    it "redirects to home page" do
      sign_in user
      delete :destroy, params: { id: tweet.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
