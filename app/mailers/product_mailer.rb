class ProductMailer < ActionMailer::Base

  def product_created(user)

  	mail(to: user.email,
  		   from: "services@gandawijaya.com",
  		   subject: "Product Created",
  		   body: "Thank you your product is a created"
  	)

  end	

end	