require "rails_helper"

RSpec.describe RetweetsController, type: :controller do
  let(:user)    { create(:user) }
  let(:tweet)   { create(:tweet, user: user) }

  describe "GET #new" do
    it "requires login" do
      sign_out user
      get :new, params: { tweet_id: tweet.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "returns http status 200" do
      sign_in user
      get :new, params: { tweet_id: tweet.id }
      expect(response).to have_http_status(:ok)
    end

    it "assigns a new retweet to an instance variable" do
      sign_in user
      get :new, params: { tweet_id: tweet.id }
      expect(assigns(:retweet)).to be_a_new(Tweet)
    end

    it "render new template" do
      sign_in user
      get :new, params: { tweet_id: tweet.id }
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "requires login" do
      sign_out user
      post :create, params: { tweet_id: tweet.id, tweet: { message: "Demo Text" }}
      expect(response).to redirect_to(new_user_session_path)
    end

    context "with valid attributes" do
      it "saves the new retweet in the database" do
        sign_in user
        expect {
          post :create, params: { tweet_id: tweet.id, tweet: { message: "Demo Text" }}
        }.to change(Tweet, :count).by(2)
      end

      it "returns http status 302" do
        sign_in user
        post :create, params: { tweet_id: tweet.id, tweet: { message: "Demo Text" }}
        expect(response).to have_http_status(:found)
      end

      it "assigns a newly created but unsaved retweet to an instance variable" do
        sign_in user
        post :create, params: { tweet_id: tweet.id, tweet: { message: "Demo Text" }}
        expect(assigns(:retweet)).to be_a(Tweet)
        expect(assigns(:retweet)).to be_persisted
      end

      it "have success flash message" do
        sign_in user
        post :create, params: { tweet_id: tweet.id, tweet: { message: "Demo Text" }}
        expect(flash[:success]).to eq(I18n.t("flash_messages.created", name: "Retweet"))
      end

      it "redirects to home page" do
        sign_in user
        post :create, params: { tweet_id: tweet.id, tweet: { message: "Demo Text" }}
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid attributes" do
      it "does not save the new retweet in the database" do
        sign_in user
        expect{
          post :create, params: { tweet_id: tweet.id, tweet: { message: "" }}
        }.to change(Tweet, :count).by(1)
      end

      it "assigns a newly created but retweet tweet an instance variable" do
        sign_in user
        post :create, params: { tweet_id: tweet.id, tweet: { message: "" }}
        expect(assigns(:retweet)).to be_a_new(Tweet)
      end

      it "returns http status 200" do
        sign_in user
        post :create, params: { tweet_id: tweet.id, tweet: { message: "" }}
        expect(response).to have_http_status(:ok)
      end

      it "re-renders the :new template" do
        sign_in user
        post :create, params: { tweet_id: tweet.id, tweet: { message: "" }}
        expect(response).to render_template(:new)
      end
    end
  end
end
