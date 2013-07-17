class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.integer :user_id
      t.string :title
      t.timestamps
    end

    add_foreign_key :books, :users, :dependent => :delete
  end

  def self.down
    drop_table :books
  end
end
