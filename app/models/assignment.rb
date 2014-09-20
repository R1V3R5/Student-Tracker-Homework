class Assignment < ActiveRecord::Base
  has_many :submissions
  has_many :users, through: :submissions
  has_many :comments, as: :commentable
  belongs_to :course

  accepts_nested_attributes_for :submissions, allow_destroy: true
end
