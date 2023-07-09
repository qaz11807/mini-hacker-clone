# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Doorkeeper::Application.count.zero?
  app = Doorkeeper::Application.new(name: 'Backfounder', redirect_uri: '', scopes: '' )
  app.uid = ENV['DEFAULT_CLIENT_ID'] if ENV['DEFAULT_CLIENT_ID']
  app.secret = ENV['DEFAULT_CLIENT_SECRET'] if ENV['DEFAULT_CLIENT_SECRET']
  app.save!
end
