class StaticPagesController < ApplicationController
  def home
  	if signed_in?
      if current_user.ninja?
        @unapproved_items = current_user.unapproved.paginate(page: params[:page])
      else
    		@question = current_user.questions.build
    		@pending_items = current_user.pending.paginate(page: params[:page])
      end
  	end
  end

  def support
  end

  def about
  end
end