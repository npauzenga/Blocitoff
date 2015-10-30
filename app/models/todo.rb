class Todo < ActiveRecord::Base
  belongs_to :user
  validates :description, presence: true

  def days_left
    7 - (DateTime.now.utc.to_date - created_at.to_date).to_i
  end
end
