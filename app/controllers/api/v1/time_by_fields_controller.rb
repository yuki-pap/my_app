class Api::V1::TimeByFieldsController < ApiController
  def index
    time_by_fields_hash = {}
    @time_by_fields = current_user.time_by_fields
    @time_by_fields.each_with_index do |f,i|
      time_by_fields_hash[i] = {color: f.color + "-image",field: f.field, count: count_conversion(f.count) }
    end

    render :json => time_by_fields_hash

  end

private



end
