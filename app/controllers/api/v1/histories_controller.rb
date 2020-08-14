class Api::V1::HistoriesController < ApiController
  #rescue_form ActiveRecord::RecordNotFound do |exception|
    #  render json: { error: '404 not found'}, status: 404
   #end

  def create


    number = current_user.histories.size
    percent = (current_user.graphs.where(fill: true).size * 100 ) / 200
    History.create(image_data_uri: params[:history][:picture] ,user_id: current_user.id,number: number, percent: percent)
    current_user.graphs.update_all(fill: false, color: "white",field: nil)

    graph_hash = make_graph_hash

    render :json => graph_hash
  end

  def index
    @histories = current_user.histories.order(:created_at)

    history_hash = {}
    @histories.each do |history|
      id = history.number
      url = history.image[:medium].url
      percent = 100 - history.percent
      create = history.created_at.strftime("%Y年%m月%d日")
      history_hash[id] = {url: url, percent: percent,create: create}
  
    end

    render :json => history_hash

  end




  private

  def history_params
    params.require(:history).permit(:picture)
  end

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
