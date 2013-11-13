class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :toggle_admin, :toggle_ninja]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:index, :destroy, :toggle_admin, :toggle_ninja]
  before_filter :correct_or_special_user, only: :show
  
  def show
  	@user = User.find(params[:id])
    if @user.ninja?
      @unapproved_items = current_user.unapproved.paginate(page: params[:page])
    else
      @answered_items = @user.answered.paginate(page: params[:page])
      @pending_items = current_user.pending.paginate(page: params[:page])
    end
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      @user.update_attribute(:q_balance, 0)
      sign_in @user
  		flash[:success] = "The Physics Ninja welcomes you."
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def toggle_admin
    @user = User.find(params[:id])
    @user.toggle!(:admin)
    flash[:success] = "Admin status changed."
    redirect_to users_path
  end

  def toggle_ninja
    @user = User.find(params[:id])
    @user.toggle!(:ninja)
    flash[:success] = "Ninja status changed."
    redirect_to users_path
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def correct_or_special_user
      @user = User.find(params[:id])
      redirect_to root_url, notice: "Sorry, grasshopper: You must be a ninja to view that page." unless current_user?(@user) || current_user.try(:admin?) || current_user.try(:ninja?)
    end
end