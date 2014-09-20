class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :join_tables
  has_many :courses, through: :join_tables
  has_many :submissions
  has_many :assignments, through: :submissions
  has_many :comments, as: :commentable
  has_many :submissions

  
  
  USER_TYPES = ["admin", "user"]
end
