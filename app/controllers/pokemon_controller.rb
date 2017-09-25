require 'httparty'

class PokemonController < ApplicationController
  def show
    api_key = ENV["GIPHY_KEY"]
    response = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{api_key}&q=#{params[:id]}&rating=g")
    body = JSON.parse(response.body)
    # byebug
    gif_url = body["data"][0]["url"]



    response = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    body = JSON.parse(response.body)



    render json: {

        "id": body["id"],
        "name": body["name"],
        "types": body["types"].map {
          |each| each["type"]["name"]
        }.first,
        "gif": gif_url
      }

  end
end
