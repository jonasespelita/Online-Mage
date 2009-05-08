module ArticlesHelper
  def show_comments_for(article)

    if article.comments.find_all_by_approved(true).size==0
      comments ="No comments yet!"
    else
      comments =""
      for comment in article.comments
        comments = comments +"<li>#{comment.body}</li>" unless !comment.approved
      end
    end

    "<div class='comments'><p><i>Comments:</i></p> <ul>" + comments +"</ul></div>
    #{link_to 'Add comment', new_article_comment_path(article) }"


  end

  def show_admin_features_for(article)
   @site_stats = SiteStat.first
   status =""
     
   
    
    if article.id ==@site_stats.top_article_id
      status =status+ "<b><span>Top Story</span></b>"
    else
      status =status+link_to("Make Top Story", promote_article_url(article)) unless article.archived
    end
    
      status = status + " | <b><span>Issue: #{article.issue.name}</span></b>" unless article.issue.nil?
      if !session[:selected_issue].nil? && session[:selected_issue] != article.issue
      status =status+" | " + link_to('Add Article', add_article_issue_path(session[:selected_issue], :article_id =>article))

    end
    
    
    
    "<div class ='article_archived'>"+status+"</div>"
  
 
  end

  def show_article(article)
     admin=""
     owned=""
     issue=""
   
    if user_is_admin?
      admin=admin+show_admin_features_for(article)
    end

    if  user_is_admin?
        unless article.issue.nil?
       issue = issue+"<div class='issue'>Issue:#{article.issue.name}</div>"
     end
      owned =  "<div class='user_options'>"+
        link_to('Show', article)+ " | "+
        link_to('Edit', edit_article_path(article))+ " | "+
        link_to('Delete', article, :confirm => 'Are you sure you want to delete this article?', :method => :delete)+
        "</div>"
    end

    "<h2>#{article.title} </h2> "+ admin+

      issue+"<div class='author'>Author:#{article.user.login }</div>
  <div class='category'>Category: #{article.category.name}</div>
  <div class='date_created'>Date Posted: #{article.created_at_friendly}</div>"+owned+

      "<div class='article_body'>
    #{article.body}
  </div>"
  end
end
