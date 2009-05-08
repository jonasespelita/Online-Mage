class CategoriesController < ApplicationController
  layout 'layout'
  def index
    
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles
    @articles.delete_if { |article| article.archived  }
  end

  def new
    @issue = Issue.find(params[:issue_id])
    session[:issue] = @issue
    @category = @issue.categories.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category}
    end
  end

  def create
    @issue = session[:issue]
    @category = @issue.categories.new(params[:category])
    
    respond_to do |format|
      if @category.save
        flash[:notice] = 'Article was successfully created.'
        format.html { redirect_to(@issue) }
        format.xml  { render :xml => @category, :status => :created, :location => @category}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end
end
