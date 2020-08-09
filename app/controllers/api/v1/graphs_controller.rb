class Api::V1::GraphsController < ApiController

# rescue_form ActiveRecord::RecordNotFound do |exception|
    #render json: { error: '404 not found'}, status: 404
  #end

  def index


    graph_hash = make_graph_hash

    render :json => graph_hash
  end


  def color
    color_hash = {}
    color_hash['red'] = current_user.markers.find_by(number:1).field
    color_hash['yellow'] = current_user.markers.find_by(number:2).field
    color_hash['blue'] = current_user.markers.find_by(number:3).field
    color_hash['lightBlue'] = current_user.markers.find_by(number:4).field
    color_hash['green'] = current_user.markers.find_by(number:5).field
    color_hash['yellowGreen'] = current_user.markers.find_by(number:6).field
    render :json => color_hash
  end




  def create
    #ストロングパラメータしっかり書く
    if params[:graph][:color]
      @study = current_user.studies.find_by(date: Time.current.strftime("%Y年%m月%d日"))
      num = @study.count + 1
      if @study.update_attributes(count: num)
          @month = current_user.months.find_by(month: Time.current.strftime("%Y年%m月"))
          n = @month.time_count + 1
          @month.update_attributes(time_count: n)
          color = params[:graph][:color]
      unless color == "white"
        @field = current_user.markers.find_by(color:color).field
        if current_user.graphs.find_by(number:params[:graph][:id]).update_attributes(fill:true,color:color ,field: @field)
           #リファクタリング必須
            unless @time_by_field = current_user.time_by_fields.find_by(field: @field)
              @time_by_field = current_user.time_by_fields.create(field: @field, count: 0)
            end
            @count = @time_by_field.count + 1
            @time_by_field.update_attributes(count: @count,color: color)

            unless @time_by_field_today = @time_by_field.time_by_field_todays.find_by(created_at: range)
              @time_by_field_today = @time_by_field.time_by_field_todays.create(count: 0)
            end

            @count = @time_by_field_today.count + 1

            @time_by_field_today.update_attributes(count: @count)


            graph_hash = make_graph_hash
            render :json => graph_hash
        else
          num = @study.count - 1
          @study.update_attributes(count: num)
          n = @month.time_count - 1
          @month.update_attributes(time_count: n)
          graph_hash = make_graph_hash_with_error
          render :json => graph_hash

        end
      else
        if current_user.graphs.find_by(number:params[:graph][:id]).update_attributes(fill:true,color:color ,field:"その他")
          field = "その他"
          #リファクタリング必須
          unless time_by_field = current_user.time_by_fields.find_by(field: field)
            time_by_field  = current_user.time_by_fields.create(field: field,count:0)
          end
          count = time_by_field.count + 1
          time_by_field.update_attributes(count: count,color: color)

          unless time_by_field_today = time_by_field.time_by_field_todays.find_by(created_at: range)
            time_by_field_today = time_by_field.time_by_field_todays.create(count:0)
          end

          count = time_by_field_today.count + 1

          time_by_field_today.update_attributes(count: count)
            graph_hash = make_graph_hash
            render :json => graph_hash
        else
          num = @study.count - 1
          @study.update_attributes(count: num)
          n = @month.time_count - 1
          @month.update_attributes(time_count: n)
          graph_hash = make_graph_hash_with_error
          render :json => graph_hash

        end

      end
      else
        graph_hash = make_graph_hash_with_vali_error
        render :json => graph_hash

      end
    else
      @study = current_user.studies.find_by(date: Time.current.strftime("%Y年%m月%d日"))
      num = @study.count - 1
      if @study.update_attributes(count: num)
        @month = current_user.months.find_by(month: Time.current.strftime("%Y年%m月"))
        n = @month.time_count - 1
        @month.update_attributes(time_count: n)

        if current_user.graphs.find_by(number:params[:graph][:id]).update_attributes(fill:false,color:"white",field: nil)
          color = params[:graph][:col]
          field = current_user.markers.find_by(color:color).field
          if @time_by_field = current_user.time_by_fields.find_by(field: field)
            count = @time_by_field.count - 1
            @time_by_field.update_attributes(count: count)
          end


          if @time_by_field_today = @time_by_field.time_by_field_todays.find_by(created_at: range)
            count = @time_by_field_today.count - 1

            @time_by_field_today.update_attributes(count: count)
          end


          graph_hash = make_graph_hash
          render :json => graph_hash
        else
          num = @study.count + 1
          @study.update_attributes(count: num)
          n = @month.time_count + 1
          @month.update_attributes(time_count: n)

          graph_hash = make_graph_hash_with_error
          render :json => graph_hash
        end

      else
        graph_hash = make_graph_hash_with_error
        render :json => graph_hash


      end
    end
  end

private
  def make_graph_hash
    graphs = current_user.graphs.select('number, color, fill,field').all
    markers = current_user.markers.select('number, field').all
    graph_hash = {}
    graphs.each do |f|
      graph = f.attributes
      id = f.number
      if graph['color'] == "white"
        graph['field'] == "その他"
      end


      graph_hash[id] = graph
    end
    #学習時間の計算
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
    graph_hash['today'] = today_time
    graph_hash['month'] = month_time
    graph_hash['all'] = all_time

    #マーカー 情報の受け渡し
    graph_hash['red'] = current_user.markers.find_by(number:1).field
    graph_hash['yellow'] = current_user.markers.find_by(number:2).field
    graph_hash['blue'] = current_user.markers.find_by(number:3).field
    graph_hash['lightBlue'] = current_user.markers.find_by(number:4).field
    graph_hash['green'] = current_user.markers.find_by(number:5).field
    graph_hash['yellowGreen'] = current_user.markers.find_by(number:6).field


    graph_hash

  end

#バリデーションエラー発生時のjsonを作成
  def make_graph_hash_with_vali_error
      graph_hash = make_graph_hash

      graph_hash['error'] = "1日は24時間ですよ!!"

      graph_hash
  end
  #予期せぬエラー発生時のjsonを作成
  def make_graph_hash_with_error
      graph_hash = make_graph_hash

      graph_hash['error'] = "エラーが発生しました。"

      graph_hash
  end









end
