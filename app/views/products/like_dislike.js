$("#product-downvote-size").html("<%= @product.get_downvotes.size %>");
$("#product-upvote-size").html("<%= @product.get_upvotes.size %>");