class NinjasController < ApplicationController
	before_filter :signed_in_user

	def new
		@ninja = current_user.ninjas.build
	end

	def create
		@ninja = Ninja.new(params[:ninja])
  	if @ninja.save
  		flash[:success] = "Your email has been submitted!"
  		redirect_to root_path
  	else
  		render 'new'
  	end
	end
end