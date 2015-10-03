class Bids::TestService

	include Virtus.model
	
	attribute :user,	User 
	attribute :bid,		Bid
	attribute :auction, auction
	
	def call
		byebug
	end
	
end