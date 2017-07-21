class EpubUploader < CarrierWave::Uploader::Base
  storage :file

  def filename
    Digest::SHA1.hexdigest(Time.now.to_s) + '.epub'
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
end
