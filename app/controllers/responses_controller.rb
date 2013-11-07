class ResponsesController < ApplicationController
  before_filter :signed_in_user
  before_filter :ninja_user

  def create
  	@question = Question.find(params[:question_id])
  	@response = @question.responses.build(params[:response])
  	@response.user = current_user

  	if @response.save
  		flash[:success] = "Many thanks, ninja."
  		redirect_to @question
  	else
  		render 'responses/index'
  	end
  end

  def index
    @question = Question.find(params[:question_id])
    @response = @question.responses.build(params[:comment])
    @response_items = @question.response_feed.paginate(page: params[:page])
  end

  def destroy
  end
end