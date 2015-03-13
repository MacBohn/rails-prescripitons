class User < ActiveRecord::Base
  has_secure_password
  has_many :prescriptions
  has_many :medications

  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
