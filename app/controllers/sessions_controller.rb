class SessionsController < ApplicationController

include SessionsHelper

	def new
		@title = "Sign in"
	end

	def create
		user = User.authenticate(params[:session][:email], params[:session][:password])
		if user.nil?
			flash.now[:error] = "Invalid email/password combination"
			@title = "Sign In"
			render 'new'
		else
			user.remember_me!
			cookies[:remember_token] = { :value => user.remember_token, :expires => 20.years.from_now.utc }
			redirect_back_or user
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end
end
