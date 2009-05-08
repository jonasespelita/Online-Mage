# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def user_owns_article?(article)
    logged_in? && article.is_owned_by_user?(current_user)
  end

  def user_is_admin?
    logged_in? && current_user.is_admin?
  end
end
