class Api::V1::FeedsController < ApiController
  def index
      feeds_hash = {}
      @following = current_user.following

      @following.each_with_index do |f,index|
        feeds_hash[index] = {description: f.description,name: f.name}

        f.time_by_fields.each_with_index do |d,i|
          if time_by_field_today = d.time_by_field_todays.find_by(created_at: range)&.count
            feeds_hash[index][i] = {color: d.color,field: d.field, count:  count_conversion(time_by_field_today) }

          end
        end
      end

      render  :json => feeds_hash


  end

private

  def range
     Date.today.beginning_of_day..Date.today.end_of_day
  end

end
