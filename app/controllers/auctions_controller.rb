class AuctionsController < ApplicationController
	
	before_action :authenticate_user!
	before_action :find_auction, only: [:show]

	def new
		@auction = Auction.new
	end
	
	def create
		@auction = Auction.new( auction_params )
		@auction.user = current_user
		@auction.current_price = 1
		
		if @auction.save
			redirect_to auction_path( @auction ), notice: "Auction created!"
		else
			render :new
		end
	end
	
	def show
		@bid = Bid.new
		@auction.reload
	end
	
	def index
		@auctions = Auction.all
	end
	
private

  def auction_params
    params.require(:auction).permit(:title, :details, :reserve_price, :end_date_time, :aasm_state)
  end

  def find_auction
  	@auction = Auction.find params[:id]
  end
  
end

