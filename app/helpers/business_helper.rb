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

  def category_links(categories)
    links = categories.map do |category|
      link_to category, '#'
    end

    safe_join links, ', '
  end

  def similar_business_links(business)
    links = business.categories.map do |category|
      content_tag :div, class: 'similar-business-category-link' do
        link_to "#{category} in #{business.address_city}"
      end
    end

    content_tag :div, id: 'similar-business-links' do
      safe_join links
    end
  end
end
