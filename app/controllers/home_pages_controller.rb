class HomePagesController < ApplicationController
  def home
  	if logged_in?
      @blog  = current_user.blogs.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  #dfasdfasdfasdf
  #sadfad
  def help
  end
end
