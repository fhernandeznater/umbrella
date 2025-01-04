require "http"
require "json"
require "dotenv/load"

# Hidden variables
pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")
gmaps_api_key = ENV.fetch("GMAPS_KEY")

# Google Maps Prompting user for a location
puts "Where are you?"

location = gets.chomp.gsub(" ", "%20")

# Using location input from user to generate a Google Maps URL to send as request

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + location + "&key=" + gmaps_api_key


# Get Latitude and Longitude

response = HTTP.get(gmaps_url)

raw_response = response.to_s

parsed_response = JSON.parse(raw_response)

first_result = parsed_response.fetch("results").at(0)

geo = first_result.fetch("geometry")

loc = geo.fetch("location")

latitude = loc.fetch("lat")

longitude = loc.fetch("lng")

# Pirate Weather section
pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/" + coordinates

# Place a GET request to the URL
raw_response = HTTP.get(pirate_weather_url)

parsed_response = JSON.parse(raw_response)

currently_hash = parsed_response.fetch("currently")

current_temp = currently_hash.fetch("temperature")

puts "The current temperature is " + current_temp.to_s + "."
