class ListingsController < ApplicationController
  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id

    if @listing.save
      redirect_to root_path, :notice => "Listing created!"
    else
      render "new"
    end
  end

  private

  def listing_params
    params.required(:listing).permit(:title, :description)
  end
end
