class HomeController < ApplicationController
  def index
    @tweets = Tweet.all.includes(:user).decending
  end
end
