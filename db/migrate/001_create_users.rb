class CreateUsers < ActiveRecord::Migration[4.2]
  def self.up
    create_table :users do |t|
      t.string :name, :null => false
      t.string :display_name, :null => false
      t.string :lower_name, :null => false
      t.timestamps
    end

    add_index :users, :name
    add_index :users, :lower_name
  end

  def self.down
    drop_table :users
  end
end
