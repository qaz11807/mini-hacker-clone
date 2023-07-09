require 'json'

namespace :hacker_news do
  desc 'extract data from hacker-news and export it'
  task :extract_and_export, [:start_id, :fetch_count, :file_name] => :environment do |_, args|
    service = HackerNews::ExtractAndExport.call(args.start_id.to_i, args.fetch_count.to_i, file_name: args.file_name)
    raise service.error if service.failed?

    puts 'Success export data from hacker-news'
  end

  desc 'transform data and load to database'
  task :transform_and_load, [:file_name] => :environment do |_, args|
    service = HackerNews::TransformAndLoad.call(args.file_name)
    raise service.error if service.failed?

    puts 'Success transform data to database'
  end
end
