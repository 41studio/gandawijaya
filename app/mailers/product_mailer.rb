class ProductMailer < ActionMailer::Base

  def product_created(user)

  	mail to: user.email,
  		   from: "services@gandawijaya.com",
  		   subject: "Product Created"
  end

end