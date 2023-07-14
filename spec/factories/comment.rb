FactoryBot.define do
  factory :comment do
    text { 'test comment' }

    trait :with_post do
      before(:create) do |comment, _|
        comment.post = create(:post, user: comment.user)
      end
    end

    after(:create) do |comment, _|
      next if comment.depth > 1

      create_list(:comment, rand(1..3), parent: comment, post: comment.post, user: comment.user)
    end
  end
end
