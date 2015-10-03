class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :user
  
  validates :amount, presence: true, numericality: {greater_than_or_equal_to: 0 }
  validates :auction, presence: true
  
  validate :bid_higher_than_current_auction_price
  
  
private

  def bid_higher_than_current_auction_price
     auction = Auction.find_by_id auction_id
     if !auction 
        return false
     end
     puts amount
     puts auction
     puts auction.current_price
     if amount <=  auction.current_price
        errors.add(:amount, "Bid too low.")
     end
  end
  
end
