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

  def shop_image(shop)
    if shop.approved?
      shop.image.url  || "noimg.png"
    elsif shop.on_progress?
      "reject.jpg"
    else
      "ue.jpg"
    end
  end

  def product_image(product)
    if product.approved?
      product.galleries.first.try(:image).try(:url) || "noimg.png"
    elsif product.on_progress?
      "reject.jpg"
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
