class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
      if @user.errors
        p "test"
      else
        p "hate"
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def tagset
    p "---"
    p params
    p "---"
    @user = User.find(params[:id])
    p @user
    @user.user_tags.create( title_of_work: params[:title_of_work],
                            character_name: params[:character_name])
    redirect_to @user
  end

  def tagdestroy
    UserTag.find(params[:id]).destroy
    flash[:success] = "deleted"
    redirect_to current_user
  end

  def images
    @user = User.find(params[:id])
  end

  private


    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def user_tags_params
      params.require(:user).permit(:title_of_work, :character_name)
    end

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
