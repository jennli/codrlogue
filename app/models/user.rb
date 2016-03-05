class User < ActiveRecord::Base

  has_many :skills, dependent: :destroy
  has_many :employments, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :projects, dependent: :destroy

  has_many :companies, through: :employments

  has_secure_password

  validates :password, length: {minimum: 6}, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
  uniqueness: true,
  format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def full_name
    "#{first_name} #{last_name}"
  end


end
