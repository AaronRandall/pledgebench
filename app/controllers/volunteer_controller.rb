class VolunteerController < ApplicationController
  def show
    @volunteer = User.find_by_username(params[:username])
  end

  def new
    @volunteer = User.new
  end

  def create
    @volunteer = User.new(volunteer_params)

    if @volunteer.save
      session[:user_id] = @volunteer.id

      redirect_to new_listing_path
    else
      render "new"
    end
  end

  private

  def volunteer_params
    params.required(:volunteer).permit(:firstname, :surname, :email, :email_confirmation, :password, :password_confirmation, :username)
  end
end
