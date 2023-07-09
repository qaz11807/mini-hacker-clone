class HackerNews::TransformAndLoad < ServiceCaller
  def initialize(file_name)
    @file_name = file_name
  end

  def call
    load_data
    create_items(@data)
  end

  private

  def load_data
    file = File.read("./data/#{@file_name}.json")
    @data = JSON.parse(file)
  end

  def create_items(items, parent: nil)
    items.each do |item|
      next if item['deleted']
      next if %w[job story comment].exclude?(item['type'])
      next if item['type'] == 'comment' && parent.nil?

      user = find_or_create_user_by_name(item['by'])

      @item = case (item['type'])
              when 'job', 'story'
                create_or_update_post(item, user)
              when 'comment'
                create_or_update_comment(item, user, parent)
              end

      next unless item['kids'].is_a? Array

      create_items(item['kids'], parent: @item)
    end
  end

  def create_or_update_comment(item, user, parent)
    comment = Comment.find_or_initialize_by(id: item['id'])
    comment.assign_attributes(text: item['text'],
                              commentable: parent,
                              user: user)
    comment.save!
    comment
  end

  def create_or_update_post(item, user)
    post = Post.find_or_initialize_by(id: item['id'])
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
