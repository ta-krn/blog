class LikesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @article = Article.find(params[:article_id])
    current_user.like(@article)
    # flash[:success] = 'いいねしました。'
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @article = Article.find(params[:article_id])
    current_user.unlike(@article)
    # flash[:success] = 'いいねを解除しました。'
    # redirect_back(fallback_location: root_path)
  end
end
