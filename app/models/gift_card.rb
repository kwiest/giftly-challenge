class GiftCard
  attr_accessor :business

  def initialize(params)
    @business = params[:business]
  end
end
