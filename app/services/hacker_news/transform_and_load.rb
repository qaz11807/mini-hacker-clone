class HackerNews::TransformAndLoad < ServiceCaller
  def initialize(file_name)
    @file_name = file_name
  end

  def call
    load_data

    @data.each do |item|
      next if item['deleted']
      next if %w[job story].exclude?(item['type'])

      user = find_or_create_user_by_name(item['by'])
      post = create_or_update_post(item, user)

      next unless item['kids'].is_a? Array

      create_comments(item['kids'], post)
    end
  end

  private

  def load_data
    file = File.read("./data/#{@file_name}.json")
    @data = JSON.parse(file)
  end

  def create_comments(items, post, parent: nil)
    items.each do |item|
      next if item['deleted']

      user = find_or_create_user_by_name(item['by'])

      comment = create_or_update_comment(item, user, post, parent: parent)

      next unless item['kids'].is_a? Array

      create_comments(item['kids'], post, parent: comment)
    end
  end

  def create_or_update_comment(item, user, post, parent: nil)
    comment = Comment.find_or_initialize_by(external_id: item['id'])
    comment.assign_attributes(text: item['text'],
                              post: post,
                              user: user)
    comment.parent = parent if parent.present?
    comment.save!
    comment
  end

  def create_or_update_post(item, user)
    post = Post.find_or_initialize_by(external_id: item['id'])
    post.assign_attributes(title: item['title'],
                           url: item['url'],
                           post_type: item['type'],
                           weight: item['score'],
                           user: user)
    post.save!
    post
  end

  def find_or_create_user_by_name(name)
    user = User.find_or_initialize_by(email: "#{name}@mock.com")
    return user if user.persisted?

    user.password = '00000000'
    user.save!
    user
  end
end
