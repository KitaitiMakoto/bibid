class CreateBooks < ActiveRecord::Migration[4.2]
  def self.up
    create_table :books do |t|
      t.integer :user_id, :null => false
      t.string :title
      t.string :epub, :null => false
      t.timestamps
    end

    add_foreign_key :books, :users, :dependent => :delete
    add_index :books, :epub, :unique => true
  end

  def self.down
    drop_table :books
  end
end
