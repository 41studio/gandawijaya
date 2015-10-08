module OffersHelper

  def create_offer(rate, content)
    click_link 'Rate & Review'
      fill_in 'review_content', with: content
      find("##{rate}", visible: false).click

    click_on 'Create Review'
  end

end

