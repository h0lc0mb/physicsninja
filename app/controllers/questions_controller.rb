class QuestionsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
  	@question = current_user.questions.build(params[:question])
  	if @question.save
  		flash[:success] = "Thanks! Your input has been submitted to the ninja."
  		redirect_to root_url
  	else
  		@pending_items = []
  		render 'static_pages/home'
  	end
  end

  def destroy
  end

  def show
  end

  def index
  end

  private

  	def correct_user
  		@question = current_user.questions.find_by_id(params[:id])
  		redirect_to root_url if @question.nil?
  	end
end