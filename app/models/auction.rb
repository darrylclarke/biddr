class Auction < ActiveRecord::Base

	belongs_to :user
	
	has_many :bids, dependent: :destroy
	has_many :bidding_users, through: :bids, source: :user

	validates :title, presence: true
	validates :end_date_time, presence: true
	validates :reserve_price, presence: true, numericality: {greater_than_or_equal_to: 0 }
	
	after_create :set_price
	
	def ordered_bids
		bids.order(:created_at).reverse_order
	end
	
	include AASM

	aasm whiny_transitions: false do
		state :published, initial: true
		state :reserve_met
		state :won
		state :cancelled
		state :reserve_not_met
	
		event :bid_amount_higher_than_reserve do
			transitions from: :published, to: :reserve_met
		end
	end
	
	def update_bid( previous_high_bid, bid )
		if previous_high_bid == nil
			self.current_price += 1
		elsif ( (bid.amount > current_price) && (bid.amount < previous_high_bid))
			self.current_price = bid.amount + 1
		else
			self.current_price = previous_high_bid + 1
		end
		
		if self.may_bid_amount_higher_than_reserve? && self.current_price >= self.reserve_price
			self.bid_amount_higher_than_reserve!
		end
		
		begin
			self.save!
		rescue => e 
			return false
		end
		true
	end
	
	
	private
	
	def set_price
		self.current_price = 1
	end
end
