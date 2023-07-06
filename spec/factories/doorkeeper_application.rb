FactoryBot.define do
  factory :doorkeeper_application, class: "Doorkeeper::Application" do
    sequence(:name) { |n| "App #{n}" }
    redirect_uri { 'https://localhost:3000' }
    scopes { '' }
  end
end
