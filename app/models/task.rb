class Task < ActiveRecord::Base

  belongs_to :employer

  validates :description, :time_in, :employer_id, presence: true

  def raw_duration
    if time_out
      time_out - time_in
    else
      0
    end
  end

  def duration
    if time_out
      minutes_hours( raw_duration / 60 )
    else
      "Open task"
    end
  end

  def is_completed
    time_out
  end

  def minutes_hours(total_min)
    if total_min >= 60
      {hours: (total_min / 60).to_i, minutes: (total_min % 60).to_i}
    else
      {hours: 0, minutes: total_min.to_i}
    end
  end

end
