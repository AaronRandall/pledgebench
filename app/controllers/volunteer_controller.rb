class VolunteerController < ApplicationController

  def new
    puts params
    @volunteer = Volunteer.new
  end

  def create
    puts params
    @volunteer = Volunteer.new(volunteer_params)

    if @volunteer.save
      redirect_to root_path
    else
      render "new"
    end
  end

  private

  def volunteer_params
    params.required(:volunteer).permit(:firstname, :surname, :email, :email_confirmation, :password, :password_confirmation)
  end

end
