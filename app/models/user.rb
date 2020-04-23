class User < ApplicationRecord
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, uniqueness: { case_sensitive: false }, presence: true,
                    length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :name, presence: true, length: { maximum: 50 }

  has_many :transactions, dependent: :destroy, foreign_key: :author_id, inverse_of: :user
end
