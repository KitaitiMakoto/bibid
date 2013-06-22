class EpubUploader < CarrierWave::Uploader::Base
  EXTENSION = '.epub'

  class << self
    attr_accessor :salt
  end

  storage :file

  def filename
    Digest::SHA1.hexdigest(salt + Time.now.to_s) + EXTENSION
  end

  def store_dir
    'components/bibi/bib/bookshelf'
  end

  def salt
    self.class.salt
  end
end
