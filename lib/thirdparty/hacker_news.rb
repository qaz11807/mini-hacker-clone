require 'json'
require 'net/http'

class ThirdParty
  class HackerNews
    def base_url
      'https://hacker-news.firebaseio.com/v0'
    end

    def fetch_item_by_id(id)
      uri = URI(item_url(id))
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Get.new(uri, {
        'Content-Type' => 'application/json',
      })
      res = http.request(req)

      data = JSON.parse(res.body)
      data['kids'] = data['kids'].map { |kid_id| fetch_item_by_id(kid_id) } if data['kids'].is_a? Array
      data
    end

    private

    def item_url(id)
      "#{base_url}/item/#{id}.json"
    end
  end
end
