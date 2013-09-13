class VolunteerController < ApplicationController

  def new
    puts params
    @volunteer = User.new
  end

  def create
    puts params
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
    params.required(:volunteer).permit(:firstname, :surname, :email, :email_confirmation, :password, :password_confirmation)
  end

end
