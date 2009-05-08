class CreateSiteStats < ActiveRecord::Migration
  def self.up
    create_table :site_stats do |t|
      t.integer :top_article_id
      t.integer :registered_users
      t.integer :total_articles
      t.integer :archived_articles

      t.timestamps
    end
  end

  def self.down
    drop_table :site_stats
  end
end
