class Medication < ActiveRecord::Base
  has_many :prescriptions

  belongs_to :user

end
