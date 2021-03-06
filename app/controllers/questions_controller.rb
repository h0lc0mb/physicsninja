class QuestionsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy
  before_filter :admin_user, only: [:pending, :answered, :commented]
  before_filter :correct_or_special_user, only: :show
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

  def pending
    @pending_items = Question.where("id not in (?)", Question.joins(:responses))
  end

  def answered
    @answered_items = Question.where("id in (?)", Question.joins(:responses))
  end

  def commented
    @new_comment_items = Question.last_comments.where("comments.user_id not in (?)", User.where(ninja: true))
  end

  private

  	def correct_user
  		@question = current_user.questions.find_by_id(params[:id])
  		redirect_to root_url if @question.nil?
  	end

    def correct_or_special_user
      @question = Question.find(params[:id])
      @user = @question.user
      redirect_to root_url, notice: "Sorry, grasshopper: You must be a ninja to view that page." unless current_user?(@user) || current_user.try(:admin?) || current_user.try(:ninja?)
    end
end