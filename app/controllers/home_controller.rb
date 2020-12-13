class HomeController < ApplicationController
  def index
    if params[:query].present?
      @tweets = Tweet.search(params[:query]).includes(:user, :comments, :retweet, :retweets).decending
    else
      @tweets = Tweet.all.includes(:user, :comments, :retweet, :retweets).decending
    end
  end
end
