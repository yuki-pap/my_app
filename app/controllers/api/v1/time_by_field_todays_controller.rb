class Api::V1::TimeByFieldTodaysController < ApiController
  def index
    time_by_field_todays_hash = {}
    @time_by_fields = User.find(params[:id]).time_by_fields
    @time_by_fields.each_with_index do |f,i|
      if time_by_field_today = f.time_by_field_todays.find_by(created_at: range)&.count
        time_by_field_todays_hash[i] = {color: f.color,field: f.field, count: count_conversion(time_by_field_today) }
      end
    end

    render :json => time_by_field_todays_hash

  end

private

  def range
     Time.zone.today.beginning_of_day..Time.zone.today.end_of_day
  end

end
