class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  has_many :books, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true, :format => {with: /\A[\w\-]+\z/}, :length => {:in => 1..24}
  validates :display_name, :presence => false
  validates :lower_name, :presence => true, :uniqueness => true, :format => {:with => /\A[a-z0-9\-_]+\z/}, :length => {:in => 1..24}


  before_validation {
    self.lower_name = self.name.downcase
    logger.debug self.lower_name.inspect
  }

  def current_file_size
    sample_book = books.first
    return 0 unless sample_book
    store_dir_path = File.join(Padrino.root, 'public', sample_book.epub.store_dir)
    Dir["#{store_dir_path}/*"].reduce(0) {|total, epub| total + File.size(epub)}
  end
end
