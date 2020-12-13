require "rails_helper"

RSpec.describe TweetsHelper, type: :helper do
  describe "#creation_timestamp" do
    let(:tweet) { create(:tweet, created_at: 4.hours.ago) }

    it "should return timestamp" do
      expect(creation_timestamp(tweet)).to eq("About 4 hours ago")
    end
  end
end
