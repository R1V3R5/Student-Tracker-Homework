class Submission < ActiveRecord::Base
  validates :title, presence: true
  belongs_to :user
  belongs_to :assignment
  has_many :comments, as: :commentable
  has_many :links
  accepts_nested_attributes_for :links, allow_destroy: true

# before_create :one_submission

# def one_submission
#   if Submission.include?(:user_id => self.user_id, :assignment_id => self.assignment_id)
#   end
# end

include Workflow
workflow do
  state :new do
    event :reviewing, transitions_to: :reviewing
  end

  state :reviewing do
    event :complete, transitions_to: :complete
    event :incomplete, transitions_to: :incomplete
  end

  state :incomplete do
    event :reviewing, transitions_to: :reviewing
    event :re_review, transitions_to: :reviewing
    event :complete, transitions_to: :complete

  end

  state :complete 
end

end
