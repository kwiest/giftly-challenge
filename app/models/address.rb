class Address
  attr_reader :street, :city, :state

  def initialize(street:, city:, state:)
    @street = street
    @city = city
    @state = state
  end

  def formatted
    "#{street}, #{city}, #{state}"
  end
end
