FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@test.com" }
    password { 'testtest' }
  end
end
