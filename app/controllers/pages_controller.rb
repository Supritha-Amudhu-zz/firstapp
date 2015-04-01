class PagesController < ApplicationController
  def home
  	@title = "Home"
  	@hometext = "Learn Ruby at Hogwarts!"
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
