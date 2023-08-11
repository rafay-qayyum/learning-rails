class ArticlesController < ApplicationController
  before_action :authenticate
  def index
    if !cookies[:first_time].present?
      cookies[:first_time]=Time.now
    else
      @time=cookies[:first_time]
    end
    @articles = Article.all
    respond_to do |format|
      format.html
      format.atom
    end
  end
  def show
    @article = Article.find(params[:id])
  end
  def new
    @article = Article.new
  end
  def create

    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      # render "new"
      flash.now[:notice] = "You have successfully logged out."
      render :new, status: :unprocessable_entity
    end
  end
  def edit
    @article = Article.find(params[:id])
  end
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, status: :see_other
  end
  private
  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
  def authenticate
    if !session[:user_id]
       redirect_to login_path
    end
  end
end
