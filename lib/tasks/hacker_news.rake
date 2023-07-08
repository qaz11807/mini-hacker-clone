require 'json'

namespace :hacker_news do
  desc 'export data from hacker-news'
  task :export, [:start_id, :fetch_count, :file_name] do |_, args|
    fetch_count = args.fetch_count.to_i || 100
    id = args.start_id.to_i || 1

    output = fetch_count.times.map do |i|
      sleep(1)

      fetcher = HackerNews.new
      fetcher.fetch_item(id + i)
    end

    filename = args.file_name || "#{id}-#{id + fetch_count}"
    File.open("./data/#{filename}.json", 'w') do |f|
      f.write(output.to_json)
    end
  end

  desc 'extract data to database'
  task :extract, [:file_name] => :environment do |_, args|
    service = HackerNews::Extract.call(args.file_name)
    raise service.error if service.failed?

    puts 'Success extract data'
  end
end
