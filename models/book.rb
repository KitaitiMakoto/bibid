class Book < ActiveRecord::Base
  belongs_to :user
  mount_uploader :epub, EpubUploader

  validates :epub, :presence => true
  validate :epub, :validate_file_size, :on => :create

  def validate_file_size
    store_dir_path = File.join(Padrino.root, 'public', epub.store_dir)
    current_file_size = Dir["#{store_dir_path}/*"].reduce(0) {|total, epub| total + File.size(epub)}
    if current_file_size + epub.size > Bibid::App.total_file_size_limit
      error_message = I18n.translate('errors.over_total_file_size', current: number_to_human_size(current_file_size), epub: number_to_human_size(epub.size), limit: number_to_human_size(Bibid::App.settings.total_file_size_limit))
      logger.info error_message
      errors.add :epub, error_message
    end
  end
end
