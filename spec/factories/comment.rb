FactoryBot.define do
  factory :comment do
    text { 'test comment' }

    trait :with_post do
      before(:create) do |comment, _|
        comment.commentable = create(:post, user: comment.user)
      end
    end

    after(:create) do |comment, _|
      next if comment.depth > 1

      create_list(:comment, rand(1..3), commentable: comment, user: comment.user)
    end
  end
end
