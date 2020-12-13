class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.new(comment_params)

    if @comment.save
      flash[:success] = t("flash_messages.created", name: "Comment")
    else
      flash[:danger] = t("flash_messages.something_went_wrong")
    end

    redirect_to tweet_path(@tweet)
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.find(params[:id])
    @comment.destroy
    flash[:danger] = t("flash_messages.deleted", name: "Comment")
    redirect_to tweet_path(@tweet)
  end

  private

  def comment_params
    params.require(:comment).permit(:message).merge(user_id: current_user.id)
  end
end
