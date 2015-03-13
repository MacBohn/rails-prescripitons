class Patient < ActiveRecord::Base

  validates_presence_of :first_name, :last_name
  has_many :prescriptions

  def full_name
    [first_name,last_name].join(" ")
  end

end
