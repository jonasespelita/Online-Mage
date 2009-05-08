class StaticController < ApplicationController
  layout 'layout'
  def index
    
  end

  def home

    unless params[:issue_id]
    @articles = @current_issue.articles
    else
      @articles = Issue.find(params[:issue_id]).articles
    end
  end

end
