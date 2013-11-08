class PurchasesController < ApplicationController
	before_filter :signed_in_user
	before_filter :correct_or_admin, only: :show

	def new
		plan = Plan.find(params[:plan_id])
		@purchase = plan.purchases.build
	end

	def create
		@purchase = Purchase.new(params[:purchase])
		@purchase.user_id = current_user.id
		#@purchase = current_user.purchases.build(params[:purchase])
		#if @purchase.save_with_payment
		if @purchase.save
			flash[:success] = "Some message"
			redirect_to @purchase
		else
			render 'new'
		end
	end

	def show
		@purchase = Purchase.find(params[:id])
	end

	def destroy
	end

	private
		def correct_or_admin
      @user = User.find(params[:id])
      redirect_to root_url, notice: "Sorry, grasshopper: You must be an admin to view that page." unless current_user?(@user) || current_user.try(:admin?)
    end
end