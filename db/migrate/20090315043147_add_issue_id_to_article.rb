class AddIssueIdToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :issue_id, :integer
  end

  def self.down
    remove_column :articles, :issue_id
  end
end
