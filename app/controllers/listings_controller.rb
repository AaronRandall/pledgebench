class ListingsController < ApplicationController
  before_filter :authentication_required

  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id

    if @listing.save
      send_create_listing_email_event(current_user.username)
      redirect_to "/#{current_user.username}", :notice => "Listing created!"
    else
      render "new"
    end
  end

  def destroy
    if @listing = Listing.find_by_id(params[:id])
      if @listing.user_id == current_user.id
        @listing.delete
        redirect_to "/#{current_user.username}", :notice => "Listing deleted!"
      else
        redirect_to root_path, :flash => { :error => "You don't have permission to do that." }
      end
    end
  end

  private

  def listing_params
    params.required(:listing).permit(
      :title, 
      :description,
      :website,
      :is_remote,
      :town,
      :county,
      :postcode,
      :enabled)
  end

  def send_create_listing_email_event(username)
    Mailer.send_analytics_email("New listing created by: #{username}", "Awesome :)")
  end
end
