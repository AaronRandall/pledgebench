class VolunteerController < ApplicationController
  require 'mailer'

  before_filter :authentication_required, :only => [:show]

  def show
    @volunteer = User.find_by_username(params[:username])
    redirect_to root_path unless @volunteer
  end

  def new
    @volunteer = User.new
  end

  def create
    @volunteer = User.new(volunteer_params)

    if @volunteer.save
      session[:user_id] = @volunteer.id
      send_create_volunteer_email_event(@volunteer.username)
      redirect_to new_listing_path, :notice => "Woohoo, welcome to Pledgebench! Let's create a listing (below) to get you setup."
    else
      render "new"
    end
  end

  private

  def volunteer_params
    params.required(:volunteer).permit(
      :firstname,
      :surname,
      :email,
      :password,
      :password_confirmation,
      :username
    )
  end

  def send_create_volunteer_email_event(username)
    Mailer.send_analytics_email("New volunteer registered with username: #{username}", "Awesome :)")
  end
end
