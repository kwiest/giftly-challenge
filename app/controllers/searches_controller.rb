class SearchesController < ApplicationController
  def new
    @businesses = Business.all
  end

  def create
    @search = Search.new(search_params)
    begin
      @search.perform
    rescue YelpApi::Error => e
      flash[:error] = e.message
      render 'new'
    end
  end


  private

  def search_params
    params.require(:search).permit(:q, :latitude, :longitude, :area_name)
  end
end
