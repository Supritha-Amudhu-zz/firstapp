class PagesController < ApplicationController
  def home
  	@title = "Home"
  	@hometext = "Sample home text!"
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
