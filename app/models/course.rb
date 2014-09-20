class Course < ActiveRecord::Base
  has_many :join_tables
  has_many :users, through: :join_tables
  has_many :assignments
  belongs_to :user

end
