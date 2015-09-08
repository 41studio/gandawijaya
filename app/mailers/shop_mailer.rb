class ShopMailer < ActionMailer::Base

  def shop_created(user)

  	mail(to: user.email,
  		   from: "services@gandawijaya.com",
  		   subject: "Shop Created",
  		   body: "Thank you your shop is a created"
  	)

  end	

end	