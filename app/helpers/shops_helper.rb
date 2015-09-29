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
end
