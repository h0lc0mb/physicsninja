class StaticPagesController < ApplicationController
  before_filter :admin_user, only: [:admin]
  
  def home
  	if signed_in?
      @user = current_user
      if current_user.ninja?
        @pending_items = Question.where("id not in (?)", Question.joins(:responses))
        @new_comment_items = current_user.new_comment.paginate(page: params[:page])
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

  def admin
    @installs = User.all
    @pending_items = Question.where("id not in (?)", Question.joins(:responses))
    @answered_items = Question.where("id in (?)", Question.joins(:responses))
    @new_comment_items = Question.last_comments.where("comments.user_id not in (?)", User.where(ninja: true)).group("questions.id")
  end
end