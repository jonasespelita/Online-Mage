class Article < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  belongs_to :category
  belongs_to :issue

  before_save :set_category_to_default

  def created_at_friendly
    self.created_at.strftime("%a %B %d, %Y %I:%M%p ")
  end

  def is_owned_by_user?(user)
    self.user_id == user.id
  end
  
  def self.search(search)
    if search
      find(:all, :conditions => ['body or title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def set_category_to_default
    self.published = false if self.published.nil?
    self.category_id = 1 if self.category_id.nil?
  end
end
