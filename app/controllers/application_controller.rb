class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  private
  
  def current_user
    # Currently a user is a volunteer only.  Will need to update for when charity signup/login exists.
    @current_user ||= Volunteer.find(session[:user_id]) if session[:user_id]
  end
end
