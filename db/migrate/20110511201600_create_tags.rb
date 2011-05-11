class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags, :force => true do |t|
      t.string :name
      t.integer :hits
      t.timestamps
    end
    add_index :tags, :hits
  end

  def self.down
    remove_index :tags, :hits
    drop_table :tags
  end
end