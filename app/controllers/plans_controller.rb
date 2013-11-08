class PlansController < ApplicationController	
	before_filter :signed_in_user
	
  def index
    @plans = Plan.order("price")
  end
end