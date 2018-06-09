require_relative "../../models/user"
require_relative "../../models/book"

class AddFieldsToBooks < ActiveRecord::Migration[4.2]
  def self.up
    change_table :books do |t|
      t.integer :file_size
    end

    Book.find_each do |book|
      book.update file_size: book.epub.file.size
    end

    change_column :books, :file_size, :integer, null: false
  end

  def self.down
    change_table :books do |t|
      t.remove :file_size
    end
  end
end
