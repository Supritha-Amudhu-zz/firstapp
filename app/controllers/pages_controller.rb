class PagesController < ApplicationController
  include SessionsHelper
  def home
  	@title = "Home"
    if signed_in?
    @micropost = Micropost.new if signed_in?
  	@hometext = "Learn Ruby at Hogwarts!"
    @feed_items = current_user.feed.paginate(:page => params[:page])
  end
  end

  def contact
  	@title = "Contact"
  end

  def help
  	@title = "Help"
  end

  def about
  	@title = "About"
  end
end
