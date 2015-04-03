# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	
  include GravatarHelper
	def title
		base_title = "Ruby On Rails Tutorial Sample App"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{h(@title)}"
		end
	end
end
