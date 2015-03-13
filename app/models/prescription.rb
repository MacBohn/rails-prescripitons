class Prescription < ActiveRecord::Base

  belongs_to :patient
  belongs_to :medication
  belongs_to :user

  validates :medication, presence: true
  validates :dosage, presence: true
  validates :schedule, presence: true
  validates :starts_on, presence: true
  validates :ends_on, presence: true

  validates_format_of :dosage, :with => /\A\d*\s.*/, :on => :create

  validate :start_date_before_end_date

  def start_date_before_end_date
    if self.starts_on && self.ends_on
      unless self.starts_on < self.ends_on
        self.errors[:starts_on] << "Must be before end date"
      end
    end
  end

end
