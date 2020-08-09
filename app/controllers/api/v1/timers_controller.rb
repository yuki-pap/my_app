class Api::V1::TimersController < ApiController
    def index

       timer_hash = {}

       today = current_user.studies.find_by(date: Time.current.strftime("%Y年%m月%d日")).count
       today_time = count_conversion(today)
       month = current_user.months.find_by(month: Time.current.strftime("%Y年%m月")).time_count
       month_time = count_conversion(month)
       studies = current_user.studies.select('count').all
       count_all = 0

       studies.each do |f|
         count_all += f.count
       end
       all_time = count_conversion(count_all)
       #学習時間の情報
       timer_hash['today'] = today_time
       timer_hash['month'] = month_time
              timer_hash['all'] = all_time
        render :json => timer_hash
    end


    def create

      timer_count = params[:timer][:count].to_i
      @study = current_user.studies.find_by(date: Time.current.strftime("%Y年%m月%d日"))
      num = @study.count + timer_count
      if @study.update_attributes(count: num)
          @month = current_user.months.find_by(month: Time.current.strftime("%Y年%m月"))
          n = @month.time_count + timer_count
          @month.update_attributes(time_count: n)
          color = params[:timer][:color]
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


            graph_hash ={}
            render :json => graph_hash
        else
           num = @study.count - 1
           @study.update_attributes(count: num)
           n = @month.time_count - 1
           @month.update_attributes(time_count: n)
           graph_hash = {}
           render :json => graph_hash

         end

      end

    end
end
