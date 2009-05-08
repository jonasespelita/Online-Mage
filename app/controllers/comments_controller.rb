class CommentsController < ApplicationController
  layout "layout"

  def index
    @unapproved_comments = Comment.find_all_by_approved false
    @approved_comments = Comment.find_all_by_approved true
  end
  def new
    @article = Article.find(params[:article_id])
    session[:article_id] = params[:article_id]
    @comment = @article.comments.new
   
  end

  def create
    @article = Article.find(session[:article_id])
    @comment = @article.comments.create(params[:comment])
    @comment.approved=false
    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created. Comment will be shown after approval of Adviser'
        format.html { redirect_to(@article) }
       
      else
        format.html { render :action => "new" }
        
      end
    end
  end
  
  def edit
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end

  def approve
    @comment = Comment.find(params[:id])
    @comment.approved=true
    @comment.save
     respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
  

end
