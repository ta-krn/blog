class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :edit, :update, :destroy, :like_articles]
  before_action :set_user, only: [:show, :destroy, :followings, :followers, :like_articles]
  
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 3)
  end
  
  def show
    @pagy, @articles = pagy(@user.articles.order(created_at: :desc), items:5)
    counts(@user)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :show
    end
  end
  
  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:success] = '更新されました'
      redirect_to @user
    else
      flash.now[:danger] = '更新されませんでした'
      render :show
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = '削除されました'
    redirect_to :root
  end
  
  def followings
    @pagy, @followings = pagy(@user.followings)
    counts(@user)
  end

  def followers
    @pagy, @followers = pagy(@user.followers)
    counts(@user)
  end

  def like_articles
    @pagy, @like_articles = pagy(@user.like_articles.order(created_at: :asc), items:5)
    counts(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
