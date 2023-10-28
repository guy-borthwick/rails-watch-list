# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb
require 'open-uri'
require 'json'

puts "Cleaning database..."
Movie.destroy_all

url = 'http://tmdb.lewagon.com/movie/top_rated'
serialized_movies = URI.open(url).read
movies_data = JSON.parse(serialized_movies)

puts "Seeding movies..."

movies_data['results'].each do |movie_hash|
  title = movie_hash['title']
  overview = movie_hash['overview']
  poster_url = "https://image.tmdb.org/t/p/w500/#{movie_hash['poster_path']}"
  rating = movie_hash['vote_average']

  Movie.create!(
    title: title,
    overview: overview,
    poster_url: poster_url,
    rating: rating
  )
end

puts "Finished seeding!"
