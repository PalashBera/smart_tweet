require "rails_helper"

describe HomeController, type: :controller do
  let(:user)  { create(:user) }
  let(:tweet) { create(:tweet) }

  describe "GET index" do
    it "returns http status 200" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "populates instance variable with an array of tweets" do
      get :index
      expect(assigns(:tweets)).to eq([tweet])
      expect(assigns(:tweets).size).to eq(1)
    end

    it "render index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
