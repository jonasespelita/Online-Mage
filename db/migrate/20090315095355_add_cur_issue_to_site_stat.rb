class AddCurIssueToSiteStat < ActiveRecord::Migration
  def self.up
    add_column :site_stats, :current_issue_id, :integer
  end

  def self.down
    remove_column :site_stats, :current_issue_id
  end
end
