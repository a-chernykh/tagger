class SetDefaultValueForHitsInTags < ActiveRecord::Migration
  def self.up
    change_column :tags, :hits, :integer, :default => 0
  end

  def self.down
    change_column :tags, :hits, :integer
  end
end