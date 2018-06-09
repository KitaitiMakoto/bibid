require "tempfile"
require Padrino.root("models/user")
require Padrino.root("models/book")

class AddUniqueIdentifierAndDescriptionAndLanguageToBooks < ActiveRecord::Migration[5.2]
  def self.up
    change_table :books do |t|
      t.string :unique_identifier
      t.text :description
      t.string :language
    end

    Book.find_each do |book|
      file = book.epub.file
      epub = if file.kind_of? CarrierWave::SanitizedFile
               EPUB::Parser.parse(file.path)
             else
               Tempfile.create {|fp|
                 fp.write file.read
                 EPUB::Parser.parse(fp.to_path)
               }
             end
      uid = epub.unique_identifier
      if uid.isbn? and !uid.content.downcase.start_with? 'urn:isbn:'
        book.unique_identifier = "urn:isbn:#{uid.content}"
      else
        book.unique_identifier = uid.content
      end
      book.description = epub.description
      book.language = epub.metadata.language.to_s
      book.save!
    end
  end

  def self.down
    change_table :books do |t|
      t.remove :unique_identifier
      t.remove :description
      t.remove :language
    end
  end
end
