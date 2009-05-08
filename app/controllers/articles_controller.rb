class ArticlesController < ApplicationController
  before_filter :login_required, :only => [:new, :edit, :destroy]
  layout 'layout'
  # GET /articles
  # GET /articles.xml
  def index

    
    @selected_issue = session[:selected_issue]
    
    @site_stats = SiteStat.first

    #   @top_article=Article.find(@site_stats.top_article_id)
  #  @articles = Article.find_all_by_issue_id(@current_issue.id)
  @articles = Article.find_all_by_published(false)



    
    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show

    @article = Article.find(params[:id])
    begin
    @issue = Issue.find(@article.issue_id)
    rescue
   
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new
    if params[:category_id]
      @category = Category.find(params[:category_id])
      session[:category_id] = params[:category_id]
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    
      
      unless current_user.is_admin?
      @article =current_user.articles.find(params[:id])
      else
        @article = Article.find(params[:id])
      end
      @issue = @article.issue
      unless @issue.nil?
      @categories = @issue.categories
      else
        @categories = []
      end
    
      
 
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = current_user.articles.new(params[:article])
    if @article.category_id.nil?
      @article.category_id = session[:category_id]
    end
    respond_to do |format|
      if @article.save
        flash[:notice] = 'Article was successfully created. Article will be shown after approval of Adviser'
        format.html { redirect_to(@article) }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        flash[:notice] = 'Article was successfully updated.'
        format.html { redirect_to(@article) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end

  def archive
    @article = Article.find(params[:id])
    @article.archived = true
    @article.save
    
    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end

  def unarchive
    @article = Article.find(params[:id])
    @article.archived = false
    @article.save

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end

  def promote
    @article = Article.find(params[:id])
    @site_stats = SiteStat.first
    @site_stats.top_article_id = @article.id
    @site_stats.save
    
    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end
  
  def search
    @searched_articles = Article.search(params[:search])
  end
end
