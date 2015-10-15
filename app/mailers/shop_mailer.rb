class ShopMailer < ActionMailer::Base

  def shop_created(user)

  	mail to: user.email,
  		   from: "services@gandawijaya.com",
  		   subject: "Shop Created"
  end

end
