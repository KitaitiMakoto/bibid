# Helper methods defined here can be accessed in any controller or view in the application

Bibid::App.helpers do
  def keep_sandbox_file_count
    existing_epubs = Dir["#{Padrino.root}/public/uploads/*.epub"].map {|path| [path, File.mtime(path)]}
    existing_epubs_count = existing_epubs.length
    existing_epubs.reverse_each.with_index do |(epub, mtime), index|
      if Time.now - mtime > settings.sandbox_retention_time
        File.delete epub rescue nil
        existing_epubs.delete_at (existing_epubs_count - index - 1)
      end
    end
    if existing_epubs.length > settings.sandbox_retention_count
      existing_epubs.sort_by! {|(epub, mtime)| mtime}.reverse!
      (existing_epubs.length - settings.sandbox_retention_count).times do
        epub = existing_epubs.pop
        File.delete epub rescue nil
      end
    end
  end
end
