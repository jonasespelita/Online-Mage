class CreateIssues < ActiveRecord::Migration
  def self.up
    create_table :issues do |t|
      t.integer :volume
      t.string :name
      t.boolean :published

      t.timestamps
    end
  end

  def self.down
    drop_table :issues
  end
end
