class GiftCardsController < ApplicationController
  def new
    business = Business.fetch(params[:business_id])
    @gift_card = GiftCard.new(business: business)
  end
end
