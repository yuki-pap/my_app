class Api::V1::TimeStampsController < ApiController
  def create
    time = params[:time_stamp][:time_to_calculate]
    color = params[:time_stamp][:color]
    time_now = Time.current.to_s
    current_user.timers.create(time_to_calculate:time,
                                  start_time:time_now,
                                  stopped_time:0,
                                  stop_time:nil,
                                  color: color)

    id_hash = {}
    id_hash['id'] = current_user.timers.first.id
    render :json => id_hash

  end

  def update
    @timer = current_user.timers.first
    if params[:time_stamp][:stop]
      @timer.update_attributes(stop_time:Time.current.to_s)
    end

    if params[:time_stamp][:start]
      stopped_time = @timer.stopped_time + (Time.now- Time.parse(@timer.stop_time)).to_i
      @timer.update_attributes(stop_time: nil,stopped_time: stopped_time)

    end


    id_hash = {}
    id_hash['id'] = current_user.timers.first.id
    render :json => id_hash
  end







end
