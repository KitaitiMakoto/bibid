Padrino::Helpers::AssetTagHelpers::APPEND_ASSET_EXTENSIONS << 'html'

Bibid::App.helpers do
  def html_import_tag(*sources)
    options = {
      rel: 'import'
    }.update(sources.extract_options!.symbolize_keys)
    sources.flatten.inject(ActiveSupport::SafeBuffer.new) do |all, source|
      all << tag(:link, {href: asset_path(:html, source)}.update(options))
    end
  end
end
