module ShopsHelper
  def product_impression_graph(id, type)
    Impression.where(impressionable_id: id, impressionable_type: type).group_by_day(:created_at, format: "%d %b %Y").count
  end
end
