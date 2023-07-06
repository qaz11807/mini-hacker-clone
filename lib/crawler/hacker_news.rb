require 'net/http'
require 'json'

class HackerNewsFectcher
  def initialize(start_id = 0)
    @start_id = start_id
  end

  def base_url
    'https://hacker-news.firebaseio.com/v0'
  end

  def fetch_item(id)
    uri = URI(item_url(id))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'

    req = Net::HTTP::Get.new(uri, {
      'Content-Type' => 'application/json',
    })
    res = http.request(req)

    data = JSON.parse(res.body)
    data['kids'] = data['kids'].map { |kid_id| fetch_item(kid_id) } if data['kids'].is_a? Array
    data
  end

  private

  def item_url(id)
    "#{base_url}/item/#{id}.json"
  end
end

DATA_COUNT = 300
id = 1

output = DATA_COUNT.times.map do |i|
  sleep(1)

  fetcher = HackerNews.new
  fetcher.fetch_item(id + i)
end

filename = "#{id}-#{id + DATA_COUNT}.json"
File.open(filename, 'w') do |f|
  f.write(output.to_json)
end
