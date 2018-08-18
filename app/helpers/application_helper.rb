module ApplicationHelper
  def rating_image_for(rating)
    if rating % 1 > 0
      path = "yelp_stars/small_#{rating.to_i}_half.png"
    else
      path = "yelp_stars/small_#{rating.to_i}.png"
    end
    image_tag path, class: 'yelp-rating-stars'
  end

  def miles_away(meters)
    miles = meters / 1609.344
    content_tag :span, "#{miles.round(1)} miles away", class: 'miles-away'
  end
end
