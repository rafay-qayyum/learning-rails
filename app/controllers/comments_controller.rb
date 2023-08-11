class CommentsController < ApplicationController
  before_action :authenticate
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    if !cookies[:commenter].present?
      cookies[:commenter]=@comment.commenter
    else
      @comment.commenter=cookies[:commenter]
      @commenter=cookies[:commenter]
    end
    #@comment.save
    redirect_to article_path(@article) # redirect to the article show page
  end
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy # delete the comment
    redirect_to article_path(@article) # redirect to the article show page
  end
  private
  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end
  def authenticate
    if !session[:user_id]
       redirect_to login_path
    end
  end
end
