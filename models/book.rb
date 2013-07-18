class Book < ActiveRecord::Base
  belongs_to :user
  mount_uploader :epub, EpubUploader

  validates :epub, :presence => true
  validate :epub, :validate_file_size, :on => :create

  def validate_file_size
    current_file_size = Dir["#{epub.store_dir}/*"].reduce(0) {|total, epub| total + File.size(epub)}
    if current_file_size + epub.size > Bibid::App.total_file_size_limit
      error_message = "total file size of stored EPUB books will be over limitation. current: #{current_file_size}, file: #{epub.size}, limit: #{Bibid::App.settings.total_file_size_limit}"
      logger.info error_message
      errors.add :epub, error_message
    end
  end
end
