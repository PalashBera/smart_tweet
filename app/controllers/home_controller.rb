class HomeController < ApplicationController
  def index
    tweets = params[:query].present? ? Tweet.search(params[:query]) : Tweet.all
    @pagy, @tweets = pagy_countless(tweets.includes(included_resources).decending, link_extra: 'data-remote="true"')
  end

  private

  def included_resources
    %i[user comments retweet retweets]
  end
end
