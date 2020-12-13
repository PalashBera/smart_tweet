class HomeController < ApplicationController
  def index
    @tweets = Tweet.all.includes(:user, :comments, :retweet, :retweets).decending
  end
end
