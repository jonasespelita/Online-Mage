# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  before_filter :init_menu
  include AuthenticatedSystem
  def init_menu
   

    case params[:controller]
    when  "articles", "static"
      @home_active = "active"
    when "categories"
      @cat_active="active"
    when "archives"
      @archives_active = "active"
    end
    @current_issue = Issue.find(SiteStat.first.current_issue_id)
    @categories = @current_issue.categories
    @archived = Issue.find_all_by_archived true
    @archived_years =  @archived.group_by { |a| a.created_at.beginning_of_year }
 

  end



  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '575e96d7120750fd90d36a5953f9d390'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
