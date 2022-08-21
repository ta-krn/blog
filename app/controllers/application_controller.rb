class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend
  
  before_action :search
  
  def search
    @search = params[:q]
    @q = Tag.includes(:articles).ransack(params[:q])
    @result = @q.result
    if @result.present?
      @articles = @result.first.articles
    end
  end
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_articles = user.articles.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_like_articles = user.like_articles.count
  end
end
