class ItemVerificationController < ApplicationController
  def new
    restaurant = Restaurant.find(params[:id])
    owners = restaurant.users
    unless owners.empty?
      conn = Faraday.new(url: ENV["EMAIL_URL"]) do |faraday|
        faraday.params["MICRO_KEY"] = ENV["MICRO_KEY"]
        faraday.params["restaurant_id"] = restaurant.id
        faraday.params["email"] = owners.first.emails.first.email
        faraday.params["num_items"] = restaurant.num_pending
        faraday.adapter Faraday.default_adapter
      end
      flash[:notice] = 'Item has been suggested to restaurant owner for approval.'
      conn.get("/verify")
    end
		redirect_to restaurant_path(params[:id])
  end
end
