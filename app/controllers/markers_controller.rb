class MarkersController < ApplicationController
  def new
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

  def create
    @markers = MarkerCollection.new(markers_params)
    if @markers.save
      redirect_to study_path(current_user.studies.find_by(date: Time.current.strftime("%Y年%m月%d日")))
    else
      render :new
    end
  end

  def edit

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

    markers = markers_params
    markers.each do |key, value|
      unless current_user.markers.find(key).update_attributes(value)
         
      end
    end

    redirect_to study_path(current_user.studies.find_by(date: Time.current.strftime("%Y年%m月%d日")))

  end


  private

  def markers_params
    params.require(:markers).permit("1": [:user_id,:field,:color],
                                    "2": [:user_id,:field,:color],
                                    "3": [:user_id,:field,:color],
                                    "4": [:user_id,:field,:color],
                                    "5": [:user_id,:field,:color],
                                    "6": [:user_id,:field,:color])
  end

end
