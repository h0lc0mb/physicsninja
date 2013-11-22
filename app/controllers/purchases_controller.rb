class PurchasesController < ApplicationController
	before_filter :signed_in_user
	before_filter :purchaser_or_admin, only: :show
	before_filter :correct_or_admin, only: :index

	def new
		plan = Plan.find(params[:plan_id])
		@purchase = plan.purchases.build
		@purchase.user = current_user
		if @purchase.user.purchases.any? && @purchase.plan.id == 1
			redirect_to plans_path
			flash[:notice] = "Nice try, grasshopper! Enterprising as you are, the first-question discount is for first purchases only. But you can buy a legit package below."
		end
	end

	def create
		@purchase = Purchase.new(params[:purchase])
		@purchase.user = current_user
		if @purchase.save_with_payment
  		sign_in @purchase.user
			flash[:success] = "You successfully purchased #{@purchase.plan.questions} questions!"
			redirect_to root_url
		else
			render 'new'
		end
	end

	def show
		@purchase = Purchase.find(params[:id])
	end

	def index
		@user = User.find(params[:user_id])
	end

	def destroy
	end

	private
		def purchaser_or_admin
      @purchase = Purchase.find(params[:id])
      redirect_to root_url, notice: "Sorry, grasshopper: You must be an admin to view that page." unless current_user.id == @purchase.user_id || current_user.try(:admin?)
    end

    def correct_or_admin
    	@user = User.find(params[:user_id])
	    redirect_to root_url, notice: "Sorry, grasshopper: You must be a ninja to view that page." unless current_user?(@user) || current_user.try(:admin?)
	  end
end