module ShopsHelper
  def product_impression_graph(id, type)
    Impression.where(impressionable_id: id, impressionable_type: type).where("created_at >= ? AND created_at < ?", Time.now.beginning_of_day, Time.now.end_of_day).group_by_day(:created_at).count
  end
end
