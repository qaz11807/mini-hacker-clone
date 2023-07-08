require 'json'

namespace :hacker_news do
  desc 'export data from hacker-news'
  task :export, [:start_id, :fetch_count, :file_name] => :environment do |_, args|
    service = HackerNews::Export.call(args.start_id.to_i, args.fetch_count.to_i, file_name: args.file_name)
    raise service.error if service.failed?

    puts 'Success export data'
  end

  desc 'extract data to database'
  task :extract, [:file_name] => :environment do |_, args|
    service = HackerNews::Extract.call(args.file_name)
    raise service.error if service.failed?

    puts 'Success extract data'
  end
end
