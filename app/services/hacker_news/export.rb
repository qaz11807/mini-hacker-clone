require './lib/thirdparty/hacker_news'

class HackerNews::Export < ServiceCaller
  def initialize(start_id, fetch_count, file_name: nil)
    @start_id = start_id.to_i || 1
    @fetch_count = fetch_count.to_i || 100
    @file_name = file_name
  end

  def call
    data = @fetch_count.times.map do |i|
      sleep(1)

      fetcher.fetch_item_by_id(@start_id + i)
    end

    export_data(data)
  end

  private

  def fetcher
    @fetcher ||= ThirdParty::HackerNews.new
  end

  def file_name
    @file_name ||= "#{@start_id}-#{@start_id + @fetch_count}"
  end

  def export_data(data)
    File.open("./data/#{file_name}.json", 'w') do |f|
      f.write(data.to_json)
    end
  end
end
