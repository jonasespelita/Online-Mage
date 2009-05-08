class AddCategoryArchivedTopstoryFeaturedToArticles < ActiveRecord::Migration
  def self.up

    add_column :articles, :archived, :boolean
    add_column :articles, :top_story, :boolean
    add_column :articles, :featured, :boolean
  end

  def self.down
    remove_column :articles, :featured
    remove_column :articles, :top_story
    remove_column :articles, :archived

  end
end
