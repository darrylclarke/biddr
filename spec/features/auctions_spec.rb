require 'rails_helper'

RSpec.feature "Auctions", type: :feature do

  describe "generating an auction" do
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
              
      end
      
      context "successful creation" do

      it "creates a new auction and shows the auction details" do
        

        
        visit new_auction_path

        fill_in "Title", with: "123abc"
        fill_in "Details", with: "detaiols"
        fill_in "Reserve price", with: "11"

        click_button "Create Auction"

        # expect(current_path).to eq(auction_path( *** need an auction id))
        expect(page).to have_text /Auction Details/i
        expect(page).to have_text /123abc/i
      end
    end

  
  
  
     context "failure creation" do

      it "creates a new auction and shows the auction details" do
        

        visit new_auction_path

        fill_in "Title", with: nil
        fill_in "Details", with: "detaiols"
        fill_in "Reserve price", with: "11"

        click_button "Create Auction"

        # expect(current_path).to eq(auction_path( *** need an auction id))
        expect(page).to have_text /can't be blank/i
      end
    end
    
  
  end


end


