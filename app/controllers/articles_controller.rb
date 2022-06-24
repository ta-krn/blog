class ArticlesController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:update, :destroy]
  # before_action :set_q, only: [:index, :search]

  def index
    # @q = Tag.includes(:articles).ransack(params[:q])
    @q = Article.includes(:tags).ransack(params[:q])
    @result = @q.result
    @pagy, @articles = pagy(Article.all.order(created_at: :desc), items: 3)
  end
  
  def show
    @article_tags = @article.tags
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = current_user.articles.build(article_params)
    tag_list = params[:article][:tag_names].split(/\s+|　/)
    @article.tags_save(tag_list)
    if @article.save
      flash[:success] = '投稿されました'
      redirect_to @article
    else
      @pagy,@articles = pagy(current_user.articles.order(id: :desc))
      flash.now[:danger] = '投稿されませんでした'
      render :new
    end
  end
  
  def edit
    @tag_list = @article.tags.pluck(:tag_name).join(nil)
  end
  
  def update
    tag_list = params[:article][:tag_names].split(nil)
    if @article.update(article_params)
      @article.tags_save(tag_list)
      flash[:success] = '更新されました'
      redirect_to @article
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @article.destroy
    flash[:success] = '削除されました'
    redirect_to controller: :users, action: :show, id: current_user.id
  end
  
  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @pagy, @articles = pagy(@tag.articles.all, items: 10)
  end
  
  def search
    @q = Article.includes(:tags).ransack(params[:q])
    # @q = Tag.includes(:articles).ransack(params[:q])
    @result = @q.result
  end
  
  private
  
  def set_article
    @article = Article.find(params[:id])
  end

  # Strong Parameter
  def article_params
    params.require(:article).permit(:title, :content)
  end
  
  def correct_user
    @article = current_user.articles.find_by(id: params[:id])
    unless @article
      flash[:notice] = '権限がありません'
      redirect_to root_url
    end
  end
end
