class CharityController < ApplicationController
  require 'mailer'

  def show
    @charity_admin = User.find_by_username(params[:username])
    redirect_to root_path unless @charity_admin
  end

  def new
    @charity_admin = User.new
    @charity = Charity.new
  end

  def create
    @charity_admin = User.new(charity_admin_params)
    @charity = Charity.new(charity_params)

    if @charity_admin.valid? && @charity.valid?
      # Create the new user & charity, and associate them
      @charity_admin.save
      @charity.user_id = @charity_admin.id
      @charity.save

      session[:user_id] = @charity_admin.id
      send_create_charity_email_event(@charity_admin.username)
      redirect_to root_path, :notice => "Woohoo, welcome to Pledgebench!"
    else
      render "new"
    end
  end

  private

  def charity_admin_params
    params.required(:charity_admin).permit(
      :firstname,
      :surname,
      :email,
      :password,
      :password_confirmation,
      :username
    )
  end

  def charity_params
    params.required(:charity).permit(
      :name,
      :registered_charity_number,
      :website
    )
  end

  def send_create_charity_email_event(username)
    Mailer.send_analytics_email("New charity registered with username: #{username}", "Awesome :)")
  end
end
