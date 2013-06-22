class EpubUploader < CarrierWave::Uploader::Base
  EXTENSION = '.epub'

  storage :file

  def filename
    Digest::SHA1.hexdigest(SALT + Time.now.to_s) + EXTENSION
  end

  def store_dir
    'components/bibi/bib/bookshelf'
  end
end
