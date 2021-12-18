class ArticlesController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:update, :destroy]

  def index
    @pagy, @articles = pagy(Article.all, items: 3)
  end
  
  def show
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      flash[:success] = '正常に投稿されました'
      redirect_to @article
    else
      @pagy,@articles = pagy(current_user.articles.order(id: :desc))
      flash.now[:danger] = '投稿されませんでした'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @article.update(article_params)
      flash[:success] = '正常に更新されました'
      redirect_to @article
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @article.destroy

    flash[:success] = '正常に削除されました'
    redirect_to articles_url
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
