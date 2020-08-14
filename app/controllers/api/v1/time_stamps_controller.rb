class Api::V1::TimeStampsController < ApiController
  def create
    if Timer.exists?(user_id: current_user.id)
      @timer = current_user.timers.all.first
      timer_count = (@timer.time_to_calculate / 15).to_i
      @study = current_user.studies.find_by(date: Time.current.strftime("%Y年%m月%d日"))
      num = @study.count + timer_count
      if @study.update_attributes(count: num)
          @month = current_user.months.find_by(month: Time.current.strftime("%Y年%m月"))
          n = @month.time_count + timer_count
          @month.update_attributes(time_count: n)
          color = @timer.color
          unless color == "white"
            @field = current_user.markers.find_by(color:color).field
          else
            @field = "その他"
          end
        @graphs = current_user.graphs.where(fill: false).first(timer_count)
        b = true
        @graphs.each do |f|
          unless f.update_attributes(fill:true,color:color ,field: @field)
            b = false
          end
        end

        if b
            unless @time_by_field = current_user.time_by_fields.find_by(field: @field)
              @time_by_field = current_user.time_by_fields.create(field: @field, count: 0)
            end
            @count = @time_by_field.count + timer_count
            @time_by_field.update_attributes(count: @count,color: color)

            unless @time_by_field_today = @time_by_field.time_by_field_todays.find_by(created_at: range)
              @time_by_field_today = @time_by_field.time_by_field_todays.create(count: 0)
            end

            @count = @time_by_field_today.count + timer_count

            @time_by_field_today.update_attributes(count: @count)

            id_hash = {}
            id_hash[:id] = nil
            render :json => id_hash
        else
           num = @study.count - 1
           @study.update_attributes(count: num)
           n = @month.time_count - 1
           @month.update_attributes(time_count: n)
           id_hash = {}
           render :json => id_hash

         end

      end

       current_user.timers.each do |f|
         f.destroy
       end


    end
    time = params[:time_stamp][:time_to_calculate]
    color = params[:time_stamp][:color]
    time_now = Time.current.to_s
    current_user.timers.create(time_to_calculate:time,
                                  start_time:time_now,
                                  stopped_time:0,
                                  stop_time:nil,
                                  color: color)

    id_hash = {}
    id_hash['id'] =  current_user.timers.order(created_at: :desc).first.id
    render :json => id_hash

  end

  def update
    @timer = current_user.timers.order(created_at: :desc).first
    if params[:time_stamp][:stop]
      @timer.update_attributes(stop_time:Time.current.to_s)
    end

    if params[:time_stamp][:start]
      stopped_time = @timer.stopped_time + (Time.now- Time.parse(@timer.stop_time)).to_i
      @timer.update_attributes(stop_time: nil,stopped_time: stopped_time)

    end


    id_hash = {}
    id_hash['id'] = current_user.timers.order(:created_at).first.id
    render :json => id_hash
  end








end
