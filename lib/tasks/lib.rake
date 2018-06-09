desc 'Update dependent packages'
task :lib => 'lib:default'

namespace :lib do
  task :default => %w[gem:default bower:default]

  desc 'Update RubyGems'
  task :gem => 'gem:update'

  desc 'Update bower packages'
  task :bower => 'bower:update'

  namespace :gem do
    task :default => :update

    desc 'Install RubyGems'
    task :install do
      sh 'bundle install --path=deps'
    end

    desc 'Update RubyGems'
    task :update do
      sh 'bundle update'
    end
  end

  namespace :bower do
    task :default => [:update, :prune, :bibi_preset]

    desc 'Install bower packages'
    task :install do
      sh 'bower install'
    end

    desc 'Update bower packages'
    task :update do
      sh 'bower update'
    end

    desc 'Prune bower packages'
    task :prune do
      sh 'bower prune'
    end

    desc 'Configure BiB/i'
    task :bibi_preset do
      bowerrc = JSON.parse(File.read(".bowerrc"))
      File.write File.join(bowerrc["directory"], "bibi/bib/i/presets/default.js"), <<PRESET
Bibi.Preset = {

// =================================================================================================

"preset-name"                : "BiB/i'd", // Name of this preset. As you like.
"preset-description"         : "Preset for BiB/i'd.", // Description for this preset. As you like.
"preset-author"              : "Kitaiti, Makoto", // Name of the author of this preset. As you like.
"preset-author-href"         : "https://diary.kitaitimakoto.net", // URI of a website, etc. of the author of this preset. As you like.

// -------------------------------------------------------------------------------------------------

"bookshelf"                  : "#{('https://storage.googleapis.com/' + ENV['CARRIERWAVE_FOG_DIRECTORY']) if ENV['CARRIERWAVE_FOG_PROVIDER'] == 'google'}/", // relative path from bib/i/index.html (if the origin is included in "trustworthy-origins", URI begins with "http://" or "https://" for COR-allowed server is OK).

"reader-view-mode"           : "paged", // "paged" or "vertical" or "horizontal" ("paged" is for flipping, "vertical" and "horizontal" are for scrolling)
"fix-reader-view-mode"       : "no", // "yes" or "no" or "desktop" or "mobile"
"single-page-always"         : "no", // "yes" or "no" or "desktop" or "mobile"

"autostart"                  : "no", // "yes" or "no" or "desktop" or "mobile"
"start-in-new-window"        : "mobile", // "yes" or "no" or "desktop" or "mobile"

"use-nombre"                 : "yes", // "yes" or "no" or "desktop" or "mobile"
"use-slider"                 : "yes", // "yes" or "no" or "desktop" or "mobile"
"use-arrows"                 : "yes", // "yes" or "no" or "desktop" or "mobile"
"use-keys"                   : "desktop", // "yes" or "no" or "desktop" or "mobile"
"use-swipe"                  : "yes", // "yes" or "no" or "desktop" or "mobile"
"use-cookie"                 : "yes", // "yes" or "no" or "desktop" or "mobile"

"cookie-expires"             : 1000 * 60 * 60 * 24 * 3, // milli-seconds (ex. 1000ms * 60s * 60m * 24h * 3d = 3days)

"ui-font-family"             : "", // CSS font-family value as "'Helvetica', sans-serif" or ""

// -------------------------------------------------------------------------------------------------

"book-background"            : "", // CSS background value or ""

"spread-gap"                 : 2, // px
"spread-margin"              : 0, // px

"spread-border-radius"       : "", // CSS border-radius value or ""
"spread-box-shadow"          : "", // CSS box-shadow value or ""

"item-padding-left"          : 28, // px
"item-padding-right"         : 28, // px
"item-padding-top"           : 40, // px
"item-padding-bottom"        : 20, // px

"flipper-width"              : 0.3, // ratio (lower than 1) or px (1 or higher)

"page-breaking"              : false, // true or false (if it is true, CSS "page-break-before/after: always;" will work, partially)

"epub-additional-stylesheet" : "", // path from spine-item or http:// URI or ""
"epub-additional-script"     : "", // path from spine-item or http:// URI or ""

// =================================================================================================

"extensions": [
    { "name": "Unzipper", "src": "extensions/unzipper/unzipper.js" }, // if the browser is Internet Explorer, this is always inactive
    { "name": "Analytics", "src" : "extensions/analytics/analytics.js", "tracking-id": "" }, // "tracking-id": Your own Google Analytics tracking id, as "UA-********-*"
    { "name": "FontSize", "src": "extensions/fontsize/fontsize.js", "base": "auto", "scale-per-step": 1.25 }, // "base": "auto" or pixel-number (if you want to change the default font-size based on the size used most frequently in each HTML)
    { "name": "Share", "src" : "extensions/share/share.js" },
    //{ "name": "EPUBCFI", "src": "extensions/epubcfi/epubcfi.js" },
    //{ "name": "OverReflow", "src": "extensions/overreflow/overreflow.js" },
    //{ "name": "JaTEx", "src": "extensions/jatex/jatex.js" },
    // ------------------------------------------------------------------------------------------
    { "name": "Bibi", "4U" : "w/0" } // (*'-'*)
],

// =================================================================================================

"trustworthy-origins": ["#{'https://storage.googleapis.com' if ENV['CARRIERWAVE_FOG_PROVIDER'] == 'google'}"]

// =================================================================================================

};
PRESET
    end

    desc "Upload BiB/i files"
    task :upload_bibi => :environment do
      settings = Bibid::App.settings
      connection = Fog::Storage.new(settings.components_host_params)
      directory = connection.directories.get(settings.components_host_directory)
      public_dir = Pathname.new(Padrino.root("public"))
      Pathname.glob(Padrino.root("public/components/bibi/**/*")).each do |path|
        next unless path.file?
        relative_path = path.relative_path_from(public_dir)
        directory.files.create(
          key: relative_path.to_path,
          body: path.open
        )
      end
    end
  end
end
