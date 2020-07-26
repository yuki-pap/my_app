class Api::V1::TasksController < ApiController

  def create
    @study = current_user.studies.find_by(date: Time.zone.now.strftime("%Y年%m月%d日"))
    @study.tasks.create!
    tasks_hash = make_tasks_hash

    render :json => tasks_hash
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    tasks_hash = make_tasks_hash

    render :json => tasks_hash
  end

  def update

     @task = Task.find(params[:id])
     
     if params[:task][:content]

       @task.update_attributes(content: params[:task][:content])
     else
       @task.update_attributes(complete: params[:task][:complete])
     end

     tasks_hash = make_tasks_hash

     render :json => tasks_hash

  end

  def index

    tasks_hash = make_tasks_hash

    render :json => tasks_hash
  end




  private


  def make_tasks_hash
    tasks_hash = {}
    @study = current_user.studies.find_by(date: Time.zone.now.strftime("%Y年%m月%d日"))

    unless @study.tasks.exists?
      (1..6).each do |f|
        @study.tasks.create!
      end
    end
    @study.tasks.each_with_index do |f,i|
      tasks_hash[i+1] = {content: f.content ,complete:f.complete,id:f.id}
    end

    tasks_hash['size'] = @study.tasks.all.size


    tasks_hash

  end


end
