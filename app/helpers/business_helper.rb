module BusinessHelper
  def formatted_price_range(price_range)
    case price_range.length
    when 1
      content_tag(:span, price_range, class: 'text-green') +
        content_tag(:span, '$$$', class: 'text-light') +
        content_tag(:span, 'under $10')
    when 2
      content_tag(:span, price_range, class: 'text-green') +
        content_tag(:span, '$$', class: 'text-light') +
        content_tag(:span, ' $11-30')
    when 3
      content_tag(:span, price_range, class: 'text-green') +
        content_tag(:span, '$', class: 'text-light') +
        content_tag(:span, ' $31-60')
    when 4
      content_tag(:span, price_range, class: 'text-green') +
        content_tag(:span, ' above $61')
    end
  end
end
