class AddFieldsToBooks < ActiveRecord::Migration
  def self.up
    change_table :books do |t|
      t.integer :file_size
    end
  end

  def self.down
    change_table :books do |t|
      t.remove :file_size
    end
  end
end
