class LocationsController < ApplicationController
  require 'net/http'
  def index
    @locations = Location.all

    render json: @locations
  end

  def create
    @location = Location.create(location_params)

    if @location.save
      render json: @location, status: :created
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  def show
    location = params[:id]
    api_key = ENV['GEOCODE_API_KEY']
    uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{api_key}")
    @geocode_response = Net::HTTP.get(uri)
    render json: @geocode_response
  end

  def location_params
    params.require(:location).permit(:address, :lat, :lng)
  end
end
