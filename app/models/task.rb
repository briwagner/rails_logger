class Task < ActiveRecord::Base

  belongs_to :employer

  validates :description, :time_in, :employer_id, presence: true

  def duration
    if time_out
      (time_out - time_in) / 60
    else
      "Open task"
    end
  end

  def is_completed
    time_out
  end

end
