require 'rails_helper'

RSpec.feature "Bids", type: :feature do

  describe "generating an bid" do
    let!(:user) { create(:user) }
  
      before do
        visit new_user_path

        validate_attributes = attributes_for(:user)

        # with fill_in you can use either the id of the input field or the
        # text for associated label with that input field
        fill_in "First name",            with: validate_attributes[:first_name]
        fill_in "Last name",             with: validate_attributes[:last_name]
        fill_in "Email",                 with: validate_attributes[:email]
        fill_in "Password",              with: validate_attributes[:password]
        fill_in "Password confirmation", with: validate_attributes[:password]

        click_button "Create User"        
              
        visit new_auction_path

        fill_in "Title", with: "123abc"
        fill_in "Details", with: "detaiols"
        fill_in "Reserve price", with: "11"

        click_button "Create Auction"
              
      end
      
      context "successful creation" do

      it "creates a bid" do
        
      # somehow you have to get to an existing auction that this user didn't create
      
        fill_in "Amount", with: "1000"
        click_button "Make your bid"

        expect(page).to have_text /Bid created/i
      end
    end

  
  
     context "failure creation" do

      it "doesn't create a bid" do
      

        fill_in "Amount", with: "1000"
        click_button "Make your bid"

        expect(page).to have_text /You can't bid on your own auctions/i
      end
    end
    
  
  end


end


