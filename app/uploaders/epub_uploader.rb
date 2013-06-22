class EpubUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    'components/bibi/bib/bookshelf'
  end
end
