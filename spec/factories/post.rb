FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "test post - #{n}" }

    trait :with_comments do
      after(:create) do |post, _|
        create_list(:comment, rand(1..5), commentable: post, user: post.user)
      end
    end
  end
end
