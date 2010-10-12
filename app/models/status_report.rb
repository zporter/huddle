class StatusReport < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  # validations
  validate :validate_has_at_least_one_status
  def validate_has_at_least_one_status
    if today.blank? && yesterday.blank?
      errors[:base] << "Must have at least one status set"
    end
  end
  
  # named scopes
  scope :by_user_name, :include => "user", :order => "users.email ASC", :conditions => "user_id IS NOT NULL"
  
  before_save :set_status_date
  
  def set_status_date
    self.status_date = Date.today if status_date.nil?
  end
end
