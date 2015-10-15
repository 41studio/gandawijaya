module ShopsHelper
  def product_impression_graph(id, type)
    Impression.where(impressionable_id: id, impressionable_type: type).group_by_day(:created_at, format: "%d %b %Y").count
  end

  def form_offer
    if user_signed_in?
      simple_form_for Offer.new, remote: true, defaults: { input_html: { class: 'form-control' } } { |f| yield  f }
    else
      simple_form_for Offer.new, defaults: { input_html: { class: 'form-control' } }  { |f| yield  f }
    end
  end

  def cover(shop)
    shop.approved? ? image_tag(shop.cover_image.cover.url) : image_tag(shop_image(shop))
  end

  def review(shop)
    shop.reviews.any? ? star_view(Time.now.to_i, shop.reviews.average(:rate_point).to_i) : 'Unrated'
  end

  def shop_image(shop)
    if shop.approved?
      shop.image.url
    elsif shop.on_progress?
      "ip.png"
    else
      "ue.jpg"
    end
  end

  def product_image(product)
    if product.approved?
      product.galleries.first.try(:image).try(:url) || "noimg.png"
    elsif product.on_progress?
      "ip.png"
    else
      "ue.jpg"
    end
  end

  def unread_by_owner?(offers)
    'unread' unless offers.where.not(user_id: current_user.id).last.try(:read_by_owner)
  end

  def unread_by_offerer?(offers)
    'unread' unless offers.where.not(user_id: current_user.id).last.try(:read_by_offerer)
  end
end
