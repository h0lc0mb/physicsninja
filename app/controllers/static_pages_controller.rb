class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		@question = current_user.questions.build
  		@pending_items = current_user.pending.paginate(page: params[:page])
  	end
  end

  def support
  end

  def about
  end
end