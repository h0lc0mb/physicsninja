class QuestionsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy
  before_filter :ninja_user, only: [:show, :index]

  def create
  	@question = current_user.questions.build(params[:question])
  	if @question.save
  		flash[:success] = "Your question has been submitted to the ninja."
  		redirect_to root_url
  	else
  		@pending_items = []
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