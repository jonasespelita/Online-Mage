class Issue < ActiveRecord::Base
  has_many :articles
  has_many :categories

  before_save :init

  def init
    if self.categories.size == 0
      category = Category.new
      category.name = "Uncategorized"
      category.issue_id = self.id
      category.save
      self.categories<<category
    end
  end
end
