class CreateAuthentications < ActiveRecord::Migration
  def self.up
    create_table :authentications do |t|
      t.integer :user_id, :null => false
      t.string :provider, :null => false
      t.string :uid, :null => false
      t.timestamps
    end

    add_foreign_key :authentications, :users, :dependent => :delete
    add_index :authentications, [:user_id, :provider], :unique => true
    add_index :authentications, [:provider, :uid], :unique => true
  end

  def self.down
    drop_table :authentications
  end
end
