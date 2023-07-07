require './lib/thirdparty/hacker_news'
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
    file = File.read("./data/#{args.file_name}.json")
    hash = JSON.parse(file).take(1)

    def find_or_create_user_by_name(name)
      user = User.find_or_initialize_by(email: "#{name}@mock.com")
      return user unless user.new_record?

      user.password = '00000000'
      user.save!
      user
    end

    def create_comment(parent, item)
      user = find_or_create_user_by_name(item['by'])

      comment = Comment.find_or_initialize_by(id: item['id'])
      comment.assign_attributes(text: item['text'],
                                commentable: parent,
                                parent: parent,
                                user: user)
      comment.save!

      item['kids'].each { |kid| create_comment(comment, kid) } if item['kids'].is_a? Array
    end

    hash.each do |item|
      next if %w[job story].exclude?(item['type'])

      user = find_or_create_user_by_name(item['by'])

      post = Post.find_or_initialize_by(id: item['id'])
      post.assign_attributes(title: item['title'],
                             url: item['url'],
                             post_type: item['type'],
                             weight: item['score'],
                             user: user)
      post.save!

      comment = post.comments.first || Comment.create!(text: 'Dummy Root', commentable: post, user: user)

      item['kids'].map { |kid| create_comment(comment, kid) } if item['kids'].is_a? Array
    end
  end
end
