class MarkersController < ApplicationController


  def edit
    unless current_user.markers.exists?
       current_user.markers.create(color:"Red",number:1,field:"未登録")
       current_user.markers.create(color:"Yellow",number:2,field:"未登録")
       current_user.markers.create(color:"Blue",number:3,field:"未登録")
       current_user.markers.create(color:"Light-Blue",number:4,field:"未登録")
       current_user.markers.create(color:"Green",number:5,field:"未登録")
       current_user.markers.create(color:"Yellow-green",number:6,field:"未登録")
    end

      unless current_user.markers.count == 6
        @markers = MarkerCollection.new
      else
        @marker = []
        current_user.markers.all.each do |f|
          @marker << f
        end


        @markers = MarkerCollection.new
        @markers.collection = @marker
      end


  end

  def update

      @marker = []
      current_user.markers.all.each do |f|
        @marker << f
      end


      @markers = MarkerCollection.new
      @markers.collection = @marker

    markers = params[:markers]
      marker_array = []
    markers.each do |key, value|
      marker_array << value
    end



    marker_array.each_with_index do |value,i|
      unless current_user.markers.find_by(number:(i+1)).update_attributes(field:value["field"])


      end
    end

    redirect_to study_path(current_user.studies.find_by(date: Time.current.strftime("%Y年%m月%d日")))

  end


  private



end
