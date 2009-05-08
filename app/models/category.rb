class Category < ActiveRecord::Base
  has_many :articles
  belongs_to :issue
end
