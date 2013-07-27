class EpubUploader < CarrierWave::Uploader::Base
  EXTENSION = '.epub'

  storage :file

  def filename
    Digest::SHA1.hexdigest(salt + Time.now.to_s) + EXTENSION
  end

  def store_dir
    File.join(super, model.user.name)
  end

  def cache_dir
    File.join(Padrino.root, 'tmp', 'uploads')
  end

  def extension_white_list
    ['epub']
  end

  def salt
    Bibid::App.settings.epub_uploader_salt
  end
end
