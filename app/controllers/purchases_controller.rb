class PurchasesController < ApplicationController
	before_filter :signed_in_user
	before_filter :correct_or_admin, only: :show

	def new
		plan = Plan.find(params[:plan_id])
		@purchase = plan.purchases.build
		@purchase.user = current_user
	end

	def create
		@purchase = Purchase.new(params[:purchase])
		@purchase.user = current_user
		if @purchase.save_with_payment
			new_balance = @purchase.user.q_balance + @purchase.plan.questions
			@purchase.user.update_attribute(:q_balance, new_balance)
			sign_in @purchase.user
			flash[:success] = "Purchase successful!"
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
      @purchase = Purchase.find(params[:id])
      redirect_to root_url, notice: "Sorry, grasshopper: You must be an admin to view that page." unless current_user.id == @purchase.user_id || current_user.try(:admin?)
    end
end