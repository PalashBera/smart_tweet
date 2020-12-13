class HomeController < ApplicationController
  def index
    if params[:query].present?
      tweets = Tweet.search(params[:query])
    else
      tweets = Tweet.all
    end

    @pagy, @tweets = pagy_countless(tweets.includes(included_resources).decending, link_extra: 'data-remote="true"')
  end

  private

  def included_resources
    %i[user comments retweet retweets]
  end
end
