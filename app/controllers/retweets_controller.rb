class RetweetsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tweet = Tweet.find(params[:tweet_id])
    @retweet = Tweet.new
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @retweet = current_user.tweets.new(tweet_params)

    if @retweet.save
      flash[:success] = t("flash_messages.created", name: "Retweet")
      redirect_to root_path
    else
      render "new"
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:message).merge(retweet_id: params[:tweet_id])
  end
end
