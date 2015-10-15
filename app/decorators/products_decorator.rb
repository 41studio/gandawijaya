class ProductsDecorator < Draper::CollectionDecorator

  def render_product
    @object ? h.render(@object) : h.content_tag(:h5, "Theres no product yet")
  end

end
