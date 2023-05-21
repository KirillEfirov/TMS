class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_secure_password

  has_many :folders, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relatioships, class_name: 'Relationship',
                                  foreign_key: 'followed_id',
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relatioships, source: :follower

  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  def follow(another_user)
    active_relationships.create(followed_id: another_user.id)
  end

  def unfollow(another_user)
    active_relationships.find_by(followed_id: another_user.id).destroy
  end

  def following?(another_user)
    following.include?(another_user)
  end
end
