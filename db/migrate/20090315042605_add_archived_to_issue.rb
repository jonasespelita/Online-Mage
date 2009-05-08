class AddArchivedToIssue < ActiveRecord::Migration
  def self.up
    add_column :issues, :archived, :boolean
  end

  def self.down
    remove_column :issues, :archived
  end
end
