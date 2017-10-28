desc "Configure Google Cloud Storage"
task :gcs => "gcs:default"

namespace :gcs do
  task :default => [:acl, :cors]

  desc "Set ACL to bucket"
  task :acl do
    bucket = (ENV['CARRIERWAVE_FOG_DIRECTORY'] || raise("CARRIERWAVE_FOG_DIRECTORY not set"))
    sh "gsutil", "defacl", "set", "public-read", "gs://#{bucket}"
  end

  desc "Set CORS to bucket"
  task :cors => File.join(__dir__, "gcs-cors.json") do |t|
    bucket = (ENV['CARRIERWAVE_FOG_DIRECTORY'] || raise("CARRIERWAVE_FOG_DIRECTORY not set"))
    cors_file = 
    sh "gsutil", "cors", "set", t.source, "gs://#{bucket}"
  end
end
