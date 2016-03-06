# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  password_digest :string
#  summary         :text
#  description     :text
#  admin           :boolean
#  is_available    :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base

  extend FriendlyId
  friendly_id :full_name, use: [:slugged, :history]

  has_many :skills, dependent: :destroy
  has_many :employments, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :projects, dependent: :destroy

  has_many :companies, through: :employments

  has_secure_password

  mount_uploader :image, ImageUploader
  mount_uploader :attachment, AttachmentUploader

  # validates_format_of :linkedin, :with => URI::regexp(%w(http https))
  # validates_format_of :github, :with => URI::regexp(%w(http https))
  # validates_format_of :twitter, :with => URI::regexp(%w(http https))
  validates :password, length: {minimum: 6}, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :summary, length: { maximum: 140 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :email, presence: true,
  uniqueness: true,
  format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  # mail boxer setting
  acts_as_messageable

  def mailboxer_email(object)
    email
  end

  # pagination per page limit
  self.per_page = 8

  def full_name
    "#{first_name} #{last_name}"
  end


end
