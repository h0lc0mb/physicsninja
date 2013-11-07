class StaticPagesController < ApplicationController
  def home
  	if signed_in?
      @user = current_user
      if current_user.ninja?
        @pending_items = Question.where("id not in (?)", Question.joins(:responses))
      else
        @question = current_user.questions.build
        @answered_items = current_user.answered.paginate(page: params[:page])
    		@pending_items = current_user.pending.paginate(page: params[:page])
      end
  	end
  end

  def support
  end

  def about
  end
end