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
    color_hash['red'] = current_user.markers.find(1).field
    color_hash['yellow'] = current_user.markers.find(2).field
    color_hash['blue'] = current_user.markers.find(3).field
    color_hash['lightBlue'] = current_user.markers.find(4).field
    color_hash['green'] = current_user.markers.find(5).field
    color_hash['yellowGreen'] = current_user.markers.find(6).field
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

        if current_user.graphs.find(params[:graph][:id]).update_attributes(fill:true,color: params[:graph][:color])
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

        if current_user.graphs.find(params[:graph][:id]).update_attributes(fill:false,color:"white")
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
    graphs = current_user.graphs.select('id, color, fill').all
    markers = current_user.markers.select('id, field').all
    graph_hash = {}
    graphs.each do |f|
      graph = f.attributes
      id = f.id


     if graph['color'] == "red"
          graph['field'] = markers.find(1).field
     elsif graph['color'] == "yellow"
          graph['field'] = markers.find(2).field
     elsif graph['color'] == "blue"
          graph['field'] = markers.find(3).field
     elsif graph['color'] == "light-blue"
          graph['field'] = markers.find(4).field
     elsif graph['color'] == "green"
          graph['field'] = markers.find(5).field
     elsif graph['color'] == "yellow-green"
          graph['field'] = markers.find(6).field

     elsif graph['color'] == "white"
       if graph['fill']
         graph['field'] = "その他"
       end
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
    graph_hash['red'] = current_user.markers.find(1).field
    graph_hash['yellow'] = current_user.markers.find(2).field
    graph_hash['blue'] = current_user.markers.find(3).field
    graph_hash['lightBlue'] = current_user.markers.find(4).field
    graph_hash['green'] = current_user.markers.find(5).field
    graph_hash['yellowGreen'] = current_user.markers.find(6).field


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

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find(user_id)

    elsif(user_id = cookies.signed[:user_id])

      user = User.find(user_id)
      if user && user.authenticated?(:remember,cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end

  end

  def count_conversion(n)
    case (n) % 4
    when 0
     "#{(n * 15) / 60}時間"
    when 1
       "#{(n * 15) / 60}時間15分"
    when 2
      "#{(n * 15) / 60}時間30分"
    else 3
      "#{(n * 15) / 60}時間45分"

    end
  end




end
