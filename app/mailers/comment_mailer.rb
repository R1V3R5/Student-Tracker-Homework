class CommentMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_comment_email(user)
    @user = user
    mail(to: user.email, subject: "Thanks")
  end

end
