class QuestionsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy
  # Add before_filter so only non-ninja, non-admin can ask questions?

  def create
  	@question = current_user.questions.build(params[:question])
    @user = current_user
  	if @question.save
      new_balance = @user.q_balance - 1
      @user.update_attribute(:q_balance, new_balance)
      sign_in @user
  		flash[:success] = "Your question has been submitted to the ninja."
      redirect_to root_url
  	else
  		@pending_items = []
      @answered_items = []
  		render 'static_pages/home'
  	end
  end

  def destroy
  end

  def show
    @question = Question.find(params[:id])
    if signed_in?
      @response = @question.responses.build
      @response_items = @question.response_feed.paginate(page: params[:page])
      @comment = @question.comments.build
      @comment_items = @question.comment_feed.paginate(page: params[:page])
    end
  end

  def index
  end

  private

  	def correct_user
  		@question = current_user.questions.find_by_id(params[:id])
  		redirect_to root_url if @question.nil?
  	end
end