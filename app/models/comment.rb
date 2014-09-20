class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user




  #   before_create :send_comment_email

  # def send_comment_email
  #   CommentMailer.new_comment_email(self).deliver
  # end
end
