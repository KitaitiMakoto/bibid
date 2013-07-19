class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :null => false
      t.string :display_name, :null => false
      t.timestamps
    end

    add_index :users, :name
  end

  def self.down
    drop_table :users
  end
end
