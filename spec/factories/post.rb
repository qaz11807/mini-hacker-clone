FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "test post - #{n}" }
    weight { rand(1..20) }
    descendants { rand(1..20) }
  end
end
