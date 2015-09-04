class CommentMailer < ActionMailer::Base

  def comment_created( user, current_user, comment )

    @user = user
    @current_user = current_user
    @comment = comment

  	mail(to: user.email,
  		   from: "services@gandawijaya.com",
  		   subject: "Comment Created",
  	)
 
    
  end	

end	