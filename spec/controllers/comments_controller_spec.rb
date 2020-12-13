require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  let(:user)    { create(:user) }
  let(:tweet)   { create(:tweet, user: user) }
  let(:comment) { create(:comment, user: user, tweet: tweet) }

  describe "POST #create" do
    it "requires login" do
      sign_out user
      post :create, params: { tweet_id: tweet.id, comment: { message: "Demo Text" }}
      expect(response).to redirect_to(new_user_session_path)
    end

    context "with valid attributes" do
      it "saves the new comment in the database" do
        sign_in user
        expect {
          post :create, params: { tweet_id: tweet.id, comment: { message: "Demo Text" }}
        }.to change(tweet.comments, :count).by(1)
      end

      it "returns http status 302" do
        sign_in user
        post :create, params: { tweet_id: tweet.id, comment: { message: "Demo Text" }}
        expect(response).to have_http_status(:found)
      end

      it "assigns a newly created but unsaved comment to an instance variable" do
        sign_in user
        post :create, params: { tweet_id: tweet.id, comment: { message: "Demo Text" }}
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:comment)).to be_persisted
      end

      it "have success flash message" do
        sign_in user
        post :create, params: { tweet_id: tweet.id, comment: { message: "Demo Text" }}
        expect(flash[:success]).to eq(I18n.t("flash_messages.created", name: "Comment"))
      end

      it "redirects to home page" do
        sign_in user
        post :create, params: { tweet_id: tweet.id, comment: { message: "Demo Text" }}
        expect(response).to redirect_to(tweet_path(tweet))
      end
    end

    context "with invalid attributes" do
      it "does not save the new comment in the database" do
        sign_in user
        expect{
          post :create, params: { tweet_id: tweet.id, comment: { message: "" }}
        }.not_to change(tweet.comments, :count)
      end

      it "assigns a newly created but comment tweet an instance variable" do
        sign_in user
        post :create, params: { tweet_id: tweet.id, comment: { message: "" }}
        expect(assigns(:comment)).to be_a_new(Comment)
      end

      it "returns http status 302" do
        sign_in user
        post :create, params: { tweet_id: tweet.id, comment: { message: "" }}
        expect(response).to have_http_status(:found)
      end

      it "have danget flash message" do
        sign_in user
        post :create, params: { tweet_id: tweet.id, comment: { message: "" }}
        expect(flash[:danger]).to eq(I18n.t("flash_messages.something_went_wrong"))
      end

      it "redirects to the tweet page" do
        sign_in user
        post :create, params: { tweet_id: tweet.id, comment: { message: "" }}
        expect(response).to redirect_to(tweet_path(tweet))
      end
    end
  end

  describe "DELETE #destroy" do
    it "requires login" do
      sign_out user
      delete :destroy, params: { tweet_id: tweet.id, id: comment.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "delete the requested comment" do
      sign_in user
      delete :destroy, params: { tweet_id: tweet.id, id: comment.id }
      expect(Comment.find_by(id: comment.id)).to eq(nil)
    end

    it "returns http status 302" do
      sign_in user
      delete :destroy, params: { tweet_id: tweet.id, id: comment.id }
      expect(response).to have_http_status(:found)
    end

    it "assigns the requested comment to an instance variable" do
      sign_in user
      delete :destroy, params: { tweet_id: tweet.id, id: comment.id }
      expect(assigns(:comment)).to eq(comment)
    end

    it "have danger flash message" do
      sign_in user
      delete :destroy, params: { tweet_id: tweet.id, id: comment.id }
      expect(flash[:danger]).to eq(I18n.t("flash_messages.deleted", name: "Comment"))
    end

    it "redirects to the tweet page" do
      sign_in user
      delete :destroy, params: { tweet_id: tweet.id, id: comment.id }
      expect(response).to redirect_to(tweet_path(tweet))
    end
  end
end
