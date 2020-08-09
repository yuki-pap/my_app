class ApiController < ActionController::API
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

  def range
     Date.today.beginning_of_day..Date.today.end_of_day
  end

end
