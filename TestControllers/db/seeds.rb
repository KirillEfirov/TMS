# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Folder.create(name: 'default_folder')

5.times do |i|
  folder = Folder.create(name: "Folder#{i + 1}")
  Card.create(word: "word#{i + 1}", translation: "translation#{i + 1}", folder: folder)
end
