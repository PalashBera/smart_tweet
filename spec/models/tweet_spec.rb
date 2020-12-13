require "rails_helper"

RSpec.describe Tweet, type: :model do
  let(:user) { create(:user) }

  describe "active record columns" do
    it { should have_db_column(:message) }
    it { should have_db_column(:user_id) }
    it { should have_db_column(:created_at) }
    it { should have_db_column(:updated_at) }
  end

  describe "active record index" do
    it { should have_db_index(:user_id) }
  end

  describe "attribute strip" do
    it { is_expected.to strip_attribute(:message).collapse_spaces }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:retweet).class_name("Tweet").optional }

    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:retweets).class_name("Tweet").with_foreign_key("retweet_id") }
  end

  describe "validations" do
    it { should validate_presence_of(:message) }
    it { should validate_length_of(:message).is_at_most(250) }
  end

  describe "#scopes" do
    context "decending" do
      let!(:tweet1) { create(:tweet) }
      let!(:tweet2) { create(:tweet) }

      it "should return tweets newly created first" do
        expect(Tweet.decending).to eq([tweet2, tweet1])
      end
    end
  end

  describe "#own_tweet?" do
    context "when tweet is created by current_user" do
      let(:current_user)  { create(:user) }
      let(:tweet)         { create(:tweet, user: current_user) }

      it "should return true" do
        expect(tweet.own_tweet?(current_user)).to eq(true)
      end
    end

    context "when tweet is not created by current_user" do
      let(:current_user)  { create(:user) }
      let(:tweet)         { create(:tweet) }

      it "should return false" do
        expect(tweet.own_tweet?(current_user)).to eq(false)
      end
    end
  end
end
