class Month < ApplicationRecord
  belongs_to :user

  def count_time
    num = self.time_count
    case (num * 15) % 60
    when 0
      "#{(num * 15) / 60}時間"
    when 15
      "#{(num * 15) / 60}時間15分"
    when 30
      "#{(num * 15) / 60}時間30分"
    else 45
      "#{(num * 15) / 60}時間45分"

    end
  end
end
