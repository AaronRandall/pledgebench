class SignupController < ApplicationController

  def new
    if current_user
      redirect_to new_listing_path
    end
  end

  def create
  end

end
