class HomeController < ApplicationController
  def index
    @tweets = Tweet.all.includes(:user, :comments).decending
  end
end
