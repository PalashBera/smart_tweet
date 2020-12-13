require "rails_helper"

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }

  describe "active record columns" do
    it { should have_db_column(:message) }
    it { should have_db_column(:user_id) }
    it { should have_db_column(:tweet_id) }
    it { should have_db_column(:created_at) }
    it { should have_db_column(:updated_at) }
  end

  describe "active record index" do
    it { should have_db_index(:user_id) }
    it { should have_db_index(:tweet_id) }
  end

  describe "attribute strip" do
    it { is_expected.to strip_attribute(:message).collapse_spaces }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:tweet) }
  end

  describe "validations" do
    it { should validate_presence_of(:message) }
    it { should validate_length_of(:message).is_at_most(250) }
  end

  describe "#scopes" do
    context "decending" do
      let!(:comment1) { create(:comment) }
      let!(:comment2) { create(:comment) }

      it "should return comments newly created first" do
        expect(Comment.decending).to eq([comment2, comment1])
      end
    end
  end

  describe "#own_comment?" do
    context "when comment is created by current_user" do
      let(:current_user)  { create(:user) }
      let(:comment)         { create(:comment, user: current_user) }

      it "should return true" do
        expect(comment.own_comment?(current_user)).to eq(true)
      end
    end

    context "when comment is not created by current_user" do
      let(:current_user)  { create(:user) }
      let(:comment)         { create(:comment) }

      it "should return false" do
        expect(comment.own_comment?(current_user)).to eq(false)
      end
    end
  end
end
