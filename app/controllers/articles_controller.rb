class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destory]

  def index
    @articles = Article.all
  end
  
  def show
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = article.new(article_params)

    if @article.save
      flash[:success] = 'Article が正常に投稿されました'
      redirect_to @article
    else
      flash.now[:danger] = 'Article が投稿されませんでした'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @article.update(article_params)
      flash[:success] = 'Article は正常に更新されました'
      redirect_to @article
    else
      flash.now[:danger] = 'Article は更新されませんでした'
      render :edit
    end
  end
  
  def destory
    @article.destroy

    flash[:success] = 'Article は正常に削除されました'
    redirect_to articles_url
  end
  
  private
  
  def set_article
    @article = Article.find(params[:id])
  end

  # Strong Parameter
  def article_params
    params.require(:article).permit(:content)
  end
end
