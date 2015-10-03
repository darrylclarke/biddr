class BidsController < ApplicationController
	before_action :authenticate_user!
	
	def create
	# bye	bug
		@auction = Auction.find params[:auction_id]
		if @auction.user == current_user
			redirect_to auction_path( @auction ), alert: "You can't bid on your own auctions!"
			return
		end
			
		previous_high_bid = nil
		all_bids = Bid.all.where( auction_id: @auction.id ).order(:amount).last
		if all_bids
			previous_high_bid = all_bids.amount
		end
		
		
		# binding.pry
		# byebug
	 	@bid = Bid.new( bid_params )
		@bid.auction_id = @auction.id
		@bid.date_time = Time.now
		@bid.user = current_user
		
		respond_to do |format| 
			if @bid.save
			
				result = @auction.update_bid( previous_high_bid, @bid )
				if !result
					redirect_to auction_path( @auction ), notice: "Error updating auction with highest bid"
					return
				end
				
				format.html { redirect_to auction_path( @auction ), notice: "Bid created" }
				format.js   { render :create_success }
			else
				format.html {
					flash[:alert] = "Bid not accepted"
					redirect_to auction_path(@auction)
				}
				format.js { render :create_failure }
			end
		end
	end
	
private

  def bid_params
    params.require(:bid).permit( :amount, :date_time )
  end

end
