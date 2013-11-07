class CommentsController < ApplicationController
  before_filter :signed_in_user

  def create
  	@question = Question.find(params[:question_id])
  	@comment = @question.comments.build(params[:comment])
  	@comment.user = current_user

  	if @comment.save
  		flash[:success] = "Comment submitted!"
      redirect_to @question
  	else
      @comment_items = []
  		render 'comments/index'
  	end
  end

  def index
    @question = Question.find(params[:question_id])
    @comment = @question.comments.build(params[:comment])
    @comment_items = @question.comment_feed.paginate(page: params[:page])
  end

  def destroy
  end
end