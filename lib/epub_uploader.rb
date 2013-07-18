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
    File.join('components/bibi/bib/bookshelf', model.user.name)
  end

  def salt
    self.class.salt
  end
end
