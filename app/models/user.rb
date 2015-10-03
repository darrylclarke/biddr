class User < ActiveRecord::Base
	has_secure_password  # password must be there and password_confirmation	has to match
	
	has_many :auctions, dependent: :destroy
	
	has_many :bids, dependent: :destroy
	has_many :bidded_auctions, through: :bids, source: :auction
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates	:email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
	validates	:first_name, presence: true
	
	
    def full_name
      "#{first_name} #{last_name}".strip
    end		
	
	# scope :successful_bids, lambda { ord(aasm_state: :published) }
 			
end
