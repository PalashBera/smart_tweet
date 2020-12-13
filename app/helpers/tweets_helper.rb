module TweetsHelper
  def creation_timestamp(tweet)
    "#{time_ago_in_words(tweet.created_at).capitalize} ago"
  end
end
