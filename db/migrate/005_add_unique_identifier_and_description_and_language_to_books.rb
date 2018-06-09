class AddUniqueIdentifierAndDescriptionAndLanguageToBooks < ActiveRecord::Migration[5.2]
  def self.up
    change_table :books do |t|
      t.string :unique_identifier
      t.text :description
      t.string :language
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
