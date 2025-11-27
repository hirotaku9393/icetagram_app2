# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "🌱 Seeds開始: #{Rails.env}環境"

user = User.find_or_create_by(email: "kazuta@example.com") do |u|
    u.name = "Kazuta"
    u.password = "password123"
    u.password_confirmation = "password123"
end

admin = Admin.find_or_create_by(email: "admin@example.com") do |a|
    a.password = "password123"
    a.password_confirmation = "password123"
end
