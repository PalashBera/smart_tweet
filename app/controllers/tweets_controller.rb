class TweetsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)

    if @tweet.save
      flash[:success] = t("flash_messages.created", name: "Tweet")
      redirect_to root_path
    else
      render "new"
    end
  end

  def edit
    @tweet = current_user.tweets.find(params[:id])
  end

  def update
    @tweet = current_user.tweets.find(params[:id])

    if @tweet.update(tweet_params)
      flash[:success] = t("flash_messages.updated", name: "Tweet")
      redirect_to root_path
    else
      render "edit"
    end
  end

  def destroy
    @tweet = current_user.tweets.find(params[:id])

    @tweet.destroy
    flash[:danger] = t("flash_messages.deleted", name: "Tweet")
    redirect_to root_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:message)
  end
end
