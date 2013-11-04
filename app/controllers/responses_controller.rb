class ResponsesController < ApplicationController
  before_filter :signed_in_user
  before_filter :ninja_user, only: :create

  def create
  	@question = Question.find(params[:question_id])
  	@response = @question.responses.build(params[:response])
  	@response.user = current_user

  	if @response.save
  		flash[:success] = "Many thanks, ninja."
  		redirect_to @question
  	else
  		render 'questions/show'
  	end
  end

  def destroy
  end
end