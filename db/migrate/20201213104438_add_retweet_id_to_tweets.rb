class AddRetweetIdToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :retweet_id, :bigint
  end
end
