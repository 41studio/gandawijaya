class OfferRoomDecorator < Draper::Decorator
  delegate_all

  # TODO create migration for room without user id
  def contact_detail
    if user_id?
      "#{user_username}(#{user_email})"
    else
      "
      Nama: #{name}</br>
      Email: #{email}</br>
      Telepon: #{telephone}</br></br>
      Penawaran: </br>
      #{ content}
      ".html_safe
    end
  end

end
