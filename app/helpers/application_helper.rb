module ApplicationHelper
  def logged?
    if session[:user_id]
      return true
    else
      return false
    end
  end
end
